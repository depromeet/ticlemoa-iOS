//
//  HomeViewModel.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Collections
import SwiftUI
import DomainInterface

struct HomeTag {
    var tag: Tag
    var size: CGFloat = 0
}

enum FilterType: String {
    case createdBy = "최신순"
    case popularBy = "인기순"
}

final class HomeViewModel: ObservableObject {
    
    @ObservedObject var modelContainer: ModelContainer
    
    @Published var articles: [TemporaryArticle] = []
    @Published var rows: [[Tag]] = []
    @Published var tags: [Tag] = []
    @Published var tagText = ""
    @Published var filterType: FilterType = .createdBy {
        didSet {
            // TODO: 최신순 / 인기순 으로 재정렬 Networking.. or something...
        }
    }
    
    @Published var selectedTag: HomeTag? {
        didSet {
            print("선택한 태그: \(selectedTag!.tag.tagName)")
            // TODO: 태그에 맞는 검색어 겸색 Netoworking...
        }
    }
    
    // Home TagList
    @Published var homeRows: [[HomeTag]] = []
    @Published var homeTags: [HomeTag] = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        modelContainer.tagModel.itemsPublisher
            .receive(on: RunLoop.main)
            .map { tags in
                return tags.map { HomeTag(tag: $0) }
            }
            .assign(to: &self.$homeTags)
        
        Task {
            do {
                try await modelContainer.tagModel.read(page: 0, take: 0)
                setupTagList()
                
            } catch {
                print("DEBUG: ", self.homeTags) // TODO: 통신 실패시, TagData의 dummy로 설정됨. 유지할지, 바꿔야할지 고민필요
                // 개발용 - 추후 삭제 필요
                setupTagList()
            }
        }
        
        // Dummy Data 셋업
        articles = TemporaryArticle.allArticles
        
        func setupTagList() {
            getTags(self.homeTags)
            if let firstTag = homeTags.first {
                selectedTag = firstTag
            }
        }
    }
    
    /// 월별 데이터 정렬 메소드
    func groupArticlesByMonth(articles: [TemporaryArticle]) -> ArticleGroup {
        guard !articles.isEmpty else { return [:] }
        
        let groupedArticles = ArticleGroup(grouping: articles) { $0.month }
        return groupedArticles
    }
    
    func getTags(_ tagList: [HomeTag]){
        print(tagList)
        var tags = tagList
        var rows: [[HomeTag]] = []
        var currentRow: [HomeTag] = []

        var totalWidth: CGFloat = 0

        let screenWidth = UIScreen.screenWidth - 10
        //        let tagSpaceing: CGFloat = 14 /*Leading Padding*/ + 30 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
        let tagSpaceing: CGFloat = 16 /*Leading Padding*/ + 16 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/

        if !tags.isEmpty {

            for index in 0..<tags.count {
                tags[index].size = tags[index].tag.tagName.getSize()
            }

            tags.forEach { tag in

                totalWidth += (tag.size + tagSpaceing)

                if totalWidth > screenWidth{
                    totalWidth = (tag.size + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                } else {
                    currentRow.append(tag)
                }
            }

            if !currentRow.isEmpty {
                rows.append(currentRow)
                currentRow.removeAll()
            }

            self.homeRows = rows
        } else {
            self.homeRows = []
        }

    }
}

// MARK: UI Configure
extension HomeViewModel {
    
    func tagButtonColor(by row: HomeTag) -> Color {
        self.selectedTag?.tag.id == row.tag.id ? Color.white : Color.grey4
    }
    
    func tagBackgroundColor(by row: HomeTag) -> Color {
        self.selectedTag?.tag.id == row.tag.id ? Color.ticlemoaBlack : Color.grey2
    }
    
}

extension HomeViewModel {
    
    func addTag(){
        // modelContainer.tagModel.create()
        tagText = ""
//        getTags()
    }
    
    func removeTag(by id: Int) {
        Task {
            do {
                try await modelContainer.tagModel.remove(tagId: id)
            } catch {
                print(error.localizedDescription)
            }
        }
        
//        getTags()
    }
    
}

