//
//  UploadArticleResponse.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/22.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let uploadArticleResponse = try? newJSONDecoder().decode(UploadArticleResponse.self, from: jsonData)

import Foundation

// MARK: - UploadArticleResponse
struct UploadArticleResponse: Codable {
    let content: String
    let isPublic: Bool
    let title: String
    let link: String
    let userID: Int
    let deletedAt: String?
    let id: Int
    let createdAt, updatedAt: String
    let viewCount: Int

    enum CodingKeys: String, CodingKey {
        case content, isPublic, title, link
        case userID = "userId"
        case deletedAt, id, createdAt, updatedAt, viewCount
    }
}


