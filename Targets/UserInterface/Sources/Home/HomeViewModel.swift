//
//  HomeViewModel.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import DomainInterface
import Combine

struct HomeTag {
    var tag: Tag
    var size: CGFloat = 0
}

final class HomeViewModel: ObservableObject {
    
    @ObservedObject var modelContainer: ModelContainer
    
    @Published var rows: [[Tag]] = []
    @Published var tags: [Tag] = []
    @Published var tagText = ""
    @Published var selectedTag: HomeTag? {
        didSet {
            print("선택한 태그: \(selectedTag!.tag)")
            if selectedTag?.tag.tagName == "전체" {
                Task {
                    do {
                        try await modelContainer.articleModel.fetch(tagId: nil)
                    } catch {
                        print(error.localizedDescription) // TODO: 실패 토스트 메세지 띄우기
                    }
                }
            } else {
                Task {
                    do {
                        try await modelContainer.articleModel.fetch(tagId: selectedTag?.tag.id)
                    } catch {
                        print(error.localizedDescription) // TODO: 실패 토스트 메세지 띄우기
                    }
                }
            }
        }
    }
    
    private var anyCancellables: [AnyCancellable] = []
    
    @Published var homeRows: [[HomeTag]] = []
    @Published var homeTags: [HomeTag] = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.modelContainer.tagModel.itemsPublisher
            .receive(on: RunLoop.main)
            .sink { tags in
                self.homeTags = [HomeTag(tag: WholeTag())]
                self.homeTags.append(contentsOf: tags.map { HomeTag(tag: $0 )})
                self.getTags(self.homeTags)
            }
            .store(in: &anyCancellables)
        
        Task {
            do {
                try await modelContainer.tagModel.read()
                try await modelContainer.articleModel.fetch(tagId: nil)
                setupTagList()
            } catch {
                setupTagList()
            }
        }
        
        func setupTagList() {
            getTags(self.homeTags)
            if let firstTag = homeTags.first {
                selectedTag = firstTag
            }
        }
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

private extension HomeViewModel {
    struct WholeTag: Tag {
        let id: Int = 0
        let userId: Int = 0
        let tagName: String = "전체"
    }
}
