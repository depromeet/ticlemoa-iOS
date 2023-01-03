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
    
    public func update(_ item: Article) async {
        do {
            guard let data = try await api.uploadArticle(by: .init(
                    accessToken: "",
                    content: item.content,
                    title: item.title,
                    url: item.url,
                    isPublic: true, // TODO: 변경 필요
                    tagIds: [] // TODO: 변경 필요
                )
            ) else {
                return
            }
            let response = try JSONDecoder().decode(UploadArticleResponse.self, from: data)
            self.items = [] // TODO: 변경 필요
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    public func remove(_ item: Article) {
        
    }
    
}
