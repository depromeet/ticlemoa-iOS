//
//  ModelContainer.swift
//  UserInterface
//
//  Created by 김용우 on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
//import DomainInterface
import Domain

public final class ModelContainer: ObservableObject {
    
    let articleModel: ArticleModelProtocol
    let tagModel: TagModelProtocol
    
    public init(
        articleModel: ArticleModelProtocol,
        tagModel: TagModelProtocol
    ) {
        self.articleModel = articleModel
        self.tagModel = tagModel
    }
    
}
