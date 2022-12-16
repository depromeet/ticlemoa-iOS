//
//  ArticleModel.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import API
import Combine

public final class ArticleModel {
    
    @Published private var _items: [Article] = []
    public var items: Published<[Article]>.Publisher { $_items }
    
    public init() {
        
    }
    
}

extension ArticleModel: Model {
    
    public func fetch() {
        
    }
    
    public func create(_ item: Article) {
    
    }
    
    public func read(_ item: Article) {
        
    }
    
    public func update(_ item: Article) {
        
    }
    
    public func remove(_ item: Article) {
        
    }
    
}
