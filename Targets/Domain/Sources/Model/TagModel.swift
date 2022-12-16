//
//  TagModel.swift
//  API
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import API
import Combine

public final class TagModel {
    
    @Published private var _items: [Tag] = []
    public var items: Published<[Tag]>.Publisher { $_items }
    
    public init() {
        
    }
    
}

extension TagModel: Model {
    
    public func fetch() {
        
    }
    
    public func create(_ item: Tag) {
    
    }
    
    public func read(_ item: Tag) {
        
    }
    
    public func update(_ item: Tag) {
        
    }
    
    public func remove(_ item: Tag) {
        
    }
    
}
