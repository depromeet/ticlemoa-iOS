//
//  Article.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/22.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

struct Article: Codable {
    let id: Int
    let createdAt: String?
    let updatedAt: String?
    let link: String
    let title: String
    let content: String
    let viewCount: Int
    let isPublic: Bool
    let userId: Int
}
