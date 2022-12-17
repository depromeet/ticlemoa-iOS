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

class HomeViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var rows: [[Tag]] = []
    @Published var tags: [Tag] = [
        Tag(name: "전체"),
        Tag(name: "빨간라인"),
        Tag(name: "넘으면"),
        Tag(name: "내려감"),
        Tag(name: "디자인"),
        Tag(name: "MD"),
        Tag(name: "커리어고민"),
        Tag(name: "CS/CX"),
        Tag(name: "인간관계"),
        Tag(name: "개발"),
        Tag(name: "마케팅"),
        Tag(name: "서비스기획"),
        Tag(name: "조직문화"),
        Tag(name: "IT/기술"),
        Tag(name: "취업 이직"),
        Tag(name: "회사생활"),
        Tag(name: "라이프스타일"),
        Tag(name: "경영/젼략")
    ]
    @Published var tagText = ""
    
    @Published var selectedTag: Tag!
    
    
    init() {
        // Dummy Data 셋업
        articles = Article.allArticles
        getTags()
        selectedTag = tags.first!
    }
    
    /// 월별 데이터 정렬 메소드
    func groupArticlesByMonth(articles: [Article]) -> ArticleGroup {
        guard !articles.isEmpty else { return [:] }
        
        let groupedArticles = ArticleGroup(grouping: articles) { $0.month }
        return groupedArticles
    }
    
    func getTags(){
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
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
    
    
    func addTag(){
        tags.append(Tag(name: tagText))
        tagText = ""
        getTags()
    }
    
    func removeTag(by id: String){
        tags = tags.filter{ $0.id != id }
        getTags()
    }
}

