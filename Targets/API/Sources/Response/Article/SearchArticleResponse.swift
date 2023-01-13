//
//  SearchArticleResponse.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct SearchArticleResponse: Decodable {
    
    public struct SearchArticle: Decodable {
        public let id: Int
        public let createdAt: String
        public let url: String
        public let imageUrl: String?
        public let title: String
        public let content: String
        public let viewCount: Int
        public let isPublic: Bool
        public let userId: Int
        public let tagIds: [Int]
    }
    
    public let articles: [SearchArticle]
    
}
