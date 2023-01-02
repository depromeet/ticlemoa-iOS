//
//  TagData.swift
//  API
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

//import DomainInterface

import Foundation

public struct TagData: Tag, Equatable, Hashable {
    public let id: UUID
    public let name: String
    public let articleIds: [UUID]
    public let created: TimeInterval
    public var size: CGFloat = 0
    
    public init(id: UUID, name: String, articleIds: [UUID], created: TimeInterval, size: CGFloat) {
        self.id = id
        self.name = name
        self.articleIds = articleIds
        self.created = created
        self.size = size
    }
}
