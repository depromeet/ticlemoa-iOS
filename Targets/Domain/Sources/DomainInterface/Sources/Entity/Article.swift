//
//  Article.swift
//  DomainInterface
//
//  Created by 김용우 on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public protocol Article {
    var id: UUID { get }
    var userID: Int { get }
    var title: String { get }
    var url: String { get }
    var content: String { get }
    var tagIds: [UUID] { get }
    var created: TimeInterval { get }
}
