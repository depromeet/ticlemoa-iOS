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
    func fetch()
    func create(_ item: Article)
    func read(_ item: Article)
    func update(_ item: Article) async
    func remove(_ item: Article)
}
