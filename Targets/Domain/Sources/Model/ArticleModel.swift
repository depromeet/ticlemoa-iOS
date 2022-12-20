//
//  ArticleModel.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import API
import DomainInterface

import Foundation

public final class ArticleModel: ArticleModelProtocol {
    
    @Published public var items: [Article] = []
    private let api: APIDetails = TiclemoaAPI()
    
    public init() {
        
    }
    
}

extension ArticleModel {
    
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
