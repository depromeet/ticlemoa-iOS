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

extension Article {
    
    func uploadArticleRequest(with loginUser: LoginUser) -> UpdateArticleRequest {
        .init(
            accessToken: loginUser.accessToken ?? "",
            path: self.id,
            body: .init(
                content: self.content,
                userId: loginUser.userId ?? 0,
                title: self.title,
                url: self.url,
                isPublic: self.isPublic,
                tagIds: self.tagIds
            )
        )
    }
    
}

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
    
    public func update(_ item: Article) async {
        let loginUser = LoginUserData(nickName: "테스트", accessToken: "토큰", userId: 0) // TODO: 전달방법 고민 필요 UserDefault?
        let uploadArticleRequest = item.uploadArticleRequest(with: loginUser)
        let result = await api.request(by: uploadArticleRequest)
        
        do {
            switch result {
                case .success(let data):
                    let response = try JSONDecoder().decode(UpdateArticleResponse.self, from: data)
                case .failure(let error):
                    print(error.description)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func remove(_ item: Article) {
        
    }
    
}
