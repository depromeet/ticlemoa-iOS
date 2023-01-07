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
    let content: String
    let isPublic: Bool
    let tagIds: [Int]
    var viewCount: Int
    var createdAt: String
    var updatedAt: String
    
    public init(
        id: Int,
        title: String,
        url: String,
        content: String,
        isPublic: Bool,
        tagIds: [Int],
        viewCount: Int,
        createdAt: String,
        updatedAt: String
    ) {
        self.id = id
        self.title = title
        self.url = url
        self.content = content
        self.isPublic = isPublic
        self.tagIds = tagIds
        self.viewCount = viewCount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
