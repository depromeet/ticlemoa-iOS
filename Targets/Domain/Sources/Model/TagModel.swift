//
//  TagModel.swift
//  API
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

import API
import DomainInterface

public final class TagModel: TagModelProtocol {
    
    @Published public var items: [Tag] = []
    
    public init() {
        
    }
    
}

extension TagModel {
    
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
