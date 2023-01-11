//
//  ArticleData.swift
//  Domain
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import DomainInterface

import Foundation

struct ArticleData: Article {
    let id: Int
    let title: String
    let url: String
    let imageUrl: String
    let content: String
    let isPublic: Bool
    var viewCount: Int
    var createdAt: String
    var updatedAt: String
    var tagIds: [Int]
    
    public init(
        id: Int,
        title: String,
        url: String,
        imageUrl: String,
        content: String,
        isPublic: Bool,
        viewCount: Int,
        createdAt: String,
        updatedAt: String,
        tagIds: [Int]
    ) {
        self.id = id
        self.title = title
        self.url = url
        self.imageUrl = imageUrl
        self.content = content
        self.isPublic = isPublic
        self.viewCount = viewCount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tagIds = tagIds
    }
}
