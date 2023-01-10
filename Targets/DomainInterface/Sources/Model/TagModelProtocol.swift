//
//  TagModelProtocol.swift
//  DomainInterface
//
//  Created by 김용우 on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Combine

public protocol TagModelProtocol {
    var itemsPublisher: Published<[Tag]>.Publisher { get }
    func create(tagName: String) async throws
    func read() async throws
    func update(tagId: Int, tagName: String) async throws
    func remove(tagId: Int) async throws
}
