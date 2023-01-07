//
//  UpdateArticleResponse.swift
//  API
//
//  Created by 김우성 on 2022/12/22.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public struct UpdateArticleResponse: Decodable {
    let content: String
    let isPublic: Bool
    let title: String
    let url: String
    let userId: Int
    let id: Int
    let deletedAt: String?
    let updatedAt: String
}


