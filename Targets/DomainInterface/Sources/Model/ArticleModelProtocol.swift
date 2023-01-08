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
    func create(_ item: Article, tagIds: [Int]) async
    func fetch() async
    func update(_ item: Article) async
    func removes(_ items: [Article]) async
    func search(_ keyword: String) async
}
