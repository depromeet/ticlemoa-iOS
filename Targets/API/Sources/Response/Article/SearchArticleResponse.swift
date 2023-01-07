//
//  SearchArticleResponse.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct SearchArticleResponse: Decodable {
    
    struct SearchArticle: Decodable {
        let id: Int
        let createdAt: String
        let updatedAt: String
        let url: String
        let title: String
        let content: String
        let viewCount: Int
        let isPublic: Bool
        let userId: Int
    }
    
    let articles: [SearchArticle]
    
}
