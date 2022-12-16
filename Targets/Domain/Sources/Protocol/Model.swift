//
//  Model.swift
//  API
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Combine

public protocol Model: ObservableObject {
    associatedtype Item
    var items: Published<[Item]>.Publisher { get }
    func fetch()
    func create(_ item: Item)
    func read(_ item: Item) // fetch
    func update(_ item: Item)
    func remove(_ item: Item)
}
