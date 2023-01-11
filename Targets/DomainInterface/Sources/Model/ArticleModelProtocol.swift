//
//  ArticleModelProtocol.swift
//  UserInterface
//
//  Created by 김용우 on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Combine

public protocol ArticleModelProtocol {
    var itemsPublisher: Published<[Article]>.Publisher { get }
    func create(_ item: Article, tagIds: [Int]) async throws
    func fetch(tagId: Int?) async throws
    func update(_ item: Article, tagIds: [Int]) async throws
    func remove(_ items: [Article]) async throws
    func search(_ keyword: String) async -> [Article]
}
