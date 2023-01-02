//
//  TagModelProtocol.swift
//  DomainInterface
//
//  Created by 김용우 on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

public protocol TagModelProtocol {
    var items: [Tag] { get }
    func fetch()
    func create(_ item: Tag)
    func read(_ item: Tag)
    func update(_ item: Tag)
    func remove(_ item: Tag)
}
