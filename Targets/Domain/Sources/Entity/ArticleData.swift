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
    let id: UUID
    let userID: Int
    let title: String
    let url: String
    let content: String
    let tagIds: [UUID]
    let created: TimeInterval
    
    public init(
        id: UUID,
        userID: Int,
        title: String,
        url: String,
        content: String,
        tagIds: [UUID],
        created: TimeInterval
    ) {
        self.id = id
        self.userID = userID
        self.title = title
        self.url = url
        self.content = content
        self.tagIds = tagIds
        self.created = created
    }
}
