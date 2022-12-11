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

class HomeViewModel: ObservableObject {
    @Published var articles: [Article] = []
    
    
    init() {
        // Dummy Data 셋업
        articles = Article.allArticles
    }
    
    /// 월별 데이터 정렬 메소드
    func groupArticlesByMonth(articles: [Article]) -> ArticleGroup {
        guard !articles.isEmpty else { return [:] }
        
        let groupedArticles = ArticleGroup(grouping: articles) { $0.month }
        print(groupedArticles)
        return groupedArticles
    }
}
