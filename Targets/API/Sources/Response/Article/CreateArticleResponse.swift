//
//  CreateArticleResponse.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct CreateArticleResponse: Decodable {
    let title: String
    let content: String
    let imageUrl: String
    let url: String
    let viewCount: Int
    let isPublic: Bool
    let userId: Int
}
