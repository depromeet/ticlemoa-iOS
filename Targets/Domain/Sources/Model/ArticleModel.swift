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
    
    func uploadArticleRequest(with accessToken: String) -> UploadArticleRequest {
        .init(
            accessToken: accessToken,
            content: self.content,
            title: self.title,
            url: self.url,
            isPublic: self.isPublic,
            tagIds: self.tagIds
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
        let uploadArticleRequest = item.uploadArticleRequest(with: "accessToken") // TODO: 전달방법 고민 필요 UserDefault?
        do {
            let data = try await api.request(by: uploadArticleRequest)
            let response = try JSONDecoder().decode(UploadArticleResponse.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func remove(_ item: Article) {
        
    }
    
}
