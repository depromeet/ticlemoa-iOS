//
//  TagModel.swift
//  Domain
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

import API
import DomainInterface

extension TagData {
    static var dummy: [Self] {
        [
            "전체", "빨간라인", "넘으면", "내려감", "디자인",
            "MD", "커리어고민", "CS/CX", "인간관계", "개발",
            "마케팅", "서비스기획", "조직문화", "IT/기술", "취업 이직",
            "회사생활", "라이프스타일", "경영/젼략"
        ].enumerated().map({
            .init(id: UUID(), name: $0.element, articleIds: [], created: .init() + Double($0.offset))
        })
    }
}

public final class TagModel: TagModelProtocol {
    
    public var itemsPublisher: Published<[DomainInterface.Tag]>.Publisher { $items }
    
    @Published private var items: [Tag] = TagData.dummy
    
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
