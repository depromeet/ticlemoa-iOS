//
//  CreateArticleResponse.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct CreateArticleResponse: Decodable {
    let content: String
    let isPublic: Bool
    let title: String
    let url: String
    let userId: Int
    let id: Int
    let createdAt: String
    let updatedAt: String
    let viewCount: Int
}
