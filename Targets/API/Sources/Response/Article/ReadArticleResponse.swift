//
//  FetchArticleResponse.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct ReadArticleResponse: Decodable {
    
    public struct ReadArticle: Decodable {
        public let content: String
        public let isPublic: Bool
        public let title: String
        public let url: String
        public let userId: Int
        public let deletedAt: String?
        public let id: Int
        public let createdAt: String
        public let updatedAt: String
        public let viewCount: Int
    }
    
    public let articles: [ReadArticle]
    
}
