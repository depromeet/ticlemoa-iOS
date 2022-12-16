//
//  Article.swift
//  Domain
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public struct Article {
    let id: UUID
    let userID: Int
    let title: String
    let url: String
    let content: String
    let tagIds: [UUID]
    let created: TimeInterval
}
