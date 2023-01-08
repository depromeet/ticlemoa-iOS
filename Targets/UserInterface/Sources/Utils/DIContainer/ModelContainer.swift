//
//  ModelContainer.swift
//  UserInterface
//
//  Created by 김용우 on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import DomainInterface

public final class ModelContainer: ObservableObject {
    
    let articleModel: ArticleModelProtocol
    let tagModel: TagModelProtocol
    let loginModel: LoginModelProtocol
    
    public init(
        articleModel: ArticleModelProtocol,
        tagModel: TagModelProtocol,
        loginModel: LoginModelProtocol
    ) {
        self.articleModel = articleModel
        self.tagModel = tagModel
        self.loginModel = loginModel
    }
    
}

#if DEBUG

extension ModelContainer {
    static var dummy: ModelContainer {
        .init(
            articleModel: MockArticleModel(),
            tagModel: MockTagModel(),
            loginModel: MockLoginModel()
        )
    }
}

#endif
