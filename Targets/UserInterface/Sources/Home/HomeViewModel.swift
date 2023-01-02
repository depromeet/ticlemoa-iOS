//
//  HomeViewModel.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import Combine
import Collections
import UIKit
import Domain

class HomeViewModel: ObservableObject {
    private var model: TagModel
    @Published var articles: [Article] = []
    @Published var rows: [[TagData]] = []
    
    var tags: [TagData] {
        get { (model.items as? [TagData]) ?? [] }
        set { model.items = newValue }
    }
    
    var tagListHeight: CGFloat {
        return CGFloat(rows.count * 35 + 35)
    }

    @Published var tagText = ""
    @Published var selectedTag: TagData!
    
    
    init(model: TagModel) {
        self.model = model
        // Dummy Data 셋업
        articles = Article.allArticles
        setupDummyTag()
        getTags()
        selectedTag = tags.first
    }
    
    private func setupDummyTag() {
        self.tags = [
            TagData(id: UUID() ,name: "전체", articleIds: [UUID()], created: TimeInterval(), size: 0),
            TagData(id: UUID() ,name: "독서", articleIds: [UUID()], created: TimeInterval(), size: 0),
            TagData(id: UUID() ,name: "공부", articleIds: [UUID()], created: TimeInterval(), size: 0),
            TagData(id: UUID() ,name: "농구", articleIds: [UUID()], created: TimeInterval(), size: 0),
            TagData(id: UUID() ,name: "커피", articleIds: [UUID()], created: TimeInterval(), size: 0),
            TagData(id: UUID() ,name: "맛집", articleIds: [UUID()], created: TimeInterval(), size: 0)
        ]

    }
    
    /// 월별 데이터 정렬 메소드
    func groupArticlesByMonth(articles: [Article]) -> ArticleGroup {
        guard !articles.isEmpty else { return [:] }
        
        let groupedArticles = ArticleGroup(grouping: articles) { $0.month }
        return groupedArticles
    }
    
    func getTags() {
        var rows: [[TagData]] = []
        var currentRow: [TagData] = []

        
        var totalWidth: CGFloat = 0
        
        let screenWidth = UIScreen.screenWidth - 10
        //        let tagSpaceing: CGFloat = 14 /*Leading Padding*/ + 30 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
        let tagSpaceing: CGFloat = 16 /*Leading Padding*/ + 16 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
        
        if !tags.isEmpty {
            
            for index in 0..<tags.count {
                self.tags[index].size = tags[index].name.getSize()
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
            
            self.rows = rows
        } else {
            self.rows = []
        }
        
    }
//
//
//    func addTag(){
//        tags.append(Tag(name: tagText))
//        tagText = ""
//        getTags()
//    }
//
//    func removeTag(by id: String){
//        tags = tags.filter{ $0.id != id }
//        getTags()
//    }

}

