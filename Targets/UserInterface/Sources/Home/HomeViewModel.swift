//
//  HomeViewModel.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import Collections
import UIKit

import SwiftUI
import DomainInterface

final class HomeViewModel: ObservableObject {
    
    @ObservedObject var modelContainer: ModelContainer
    
    @Published var articles: [TemporaryArticle] = []
    @Published var rows: [[Tag]] = []
    @Published var tags: [Tag] = []
    @Published var tagText = ""
    
    @Published var selectedTag: Tag?
        
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        modelContainer.tagModel.itemsPublisher
            .receive(on: RunLoop.main)
            .assign(to: &self.$tags)
        
        Task {
            do {
                try await modelContainer.tagModel.read()
                print(self.tags)
            } catch {
                print(self.tags) // TODO: 통신 실패시, TagData의 dummy로 설정됨. 유지할지, 바꿔야할지 고민필요
            }
            selectedTag = tags.first
        }
    
        
        // Dummy Data 셋업
        articles = TemporaryArticle.allArticles
//        getTags()
    }
    
    /// 월별 데이터 정렬 메소드
    func groupArticlesByMonth(articles: [TemporaryArticle]) -> ArticleGroup {
        guard !articles.isEmpty else { return [:] }
        
        let groupedArticles = ArticleGroup(grouping: articles) { $0.month }
        return groupedArticles
    }
    
//    func getTags(){
//        var rows: [[Tag]] = []
//        var currentRow: [Tag] = []
//
//        var totalWidth: CGFloat = 0
//
//        let screenWidth = UIScreen.screenWidth - 10
//        //        let tagSpaceing: CGFloat = 14 /*Leading Padding*/ + 30 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
//        let tagSpaceing: CGFloat = 16 /*Leading Padding*/ + 16 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
//
//        if !tags.isEmpty {
//
//            for index in 0..<tags.count {
//                self.tags[index].size = tags[index].name.getSize()
//            }
//
//            tags.forEach { tag in
//
//                totalWidth += (tag.size + tagSpaceing)
//
//                if totalWidth > screenWidth{
//                    totalWidth = (tag.size + tagSpaceing)
//                    rows.append(currentRow)
//                    currentRow.removeAll()
//                    currentRow.append(tag)
//                } else {
//                    currentRow.append(tag)
//                }
//            }
//
//            if !currentRow.isEmpty {
//                rows.append(currentRow)
//                currentRow.removeAll()
//            }
//
//            self.rows = rows
//        } else {
//            self.rows = []
//        }
//
//    }
}

// MARK: UI Configure
extension HomeViewModel {
    
    func tagButtonColor(by row: Tag) -> Color {
        self.selectedTag?.id == row.id ? Color.white : Color.grey4
    }
    
    func tagBackgroundColor(by row: Tag) -> Color {
        self.selectedTag?.id == row.id ? Color.ticlemoaBlack : Color.grey2
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

