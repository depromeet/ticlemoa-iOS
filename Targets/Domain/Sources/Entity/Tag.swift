//
//  Tag.swift
//  API
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public struct Tag {
    let id: UUID
    let name: String
    let articleIds: [UUID]
    let created: TimeInterval
}
