//
//  Tag.swift
//  nyongnyong_iOSManifests
//
//  Created by 김용우 on 2022/12/20.
//

import Foundation

public protocol Tag {
    var id: Int { get }
    var userId: Int { get }
    var tagName: String { get }
}
