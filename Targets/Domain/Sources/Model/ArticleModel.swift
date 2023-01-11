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
    
    public var itemsPublisher: Published<[Article]>.Publisher { $items }
    
    @Published private var items: [Article] = []
    private let api: APIDetails = TiclemoaAPI()
    
    public init() {
        
    }
    
}

extension ArticleModel {
    
    public func create(_ item: Article, tagIds: [Int]) async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        let request = CreateArticleRequest(
            accessToken: currentUser.accessToken,
            body: .init(
                content: item.content,
                userId: currentUser.userId,
                title: item.title,
                url: item.url,
                isPublic: item.isPublic,
                tagIds: tagIds
            )
        )
        
        let result = await api.request(by: request)
        
        switch result {
        case .success(let data):
            _ = try JSONDecoder().decode(CreateArticleResponse.self, from: data)
            try await self.fetch()
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
    
    public func fetch(tagId: Int? = nil) async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        let request = ReadArticleRequest(
            accessToken: currentUser.accessToken,
            userId: currentUser.userId,
            tagId: tagId
        )
        let result = await api.request(by: request)
            
        switch result {
        case .success(let data):
            let response = try JSONDecoder().decode(ReadArticleResponse.self, from: data)
            DispatchQueue.main.async {
                self.items = response.articles.map({
                    ArticleData(
                        id: $0.id,
                        title: $0.title,
                        url: $0.url,
                        imageUrl: "",
                        content: $0.content,
                        isPublic: $0.isPublic,
                        viewCount: $0.viewCount,
                        createdAt: "",
                        updatedAt: "",
                        tagIds: $0.tagIds
                    )
                })
            }
        case .failure(let network):
            throw DomainInterfaceError.networkError(code: network.code)
        }
    }
    
    public func update(_ item: Article, tagIds: [Int]) async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        let request = UpdateArticleRequest(
            accessToken: currentUser.accessToken,
            articleId: item.id,
            body: .init(
                content: item.content,
                userId: currentUser.userId,
                title: item.title,
                url: item.url,
                isPublic: item.isPublic,
                tagIds: tagIds
            )
        )
        let result = await api.request(by: request)
        
        
        switch result {
        case .success(let data):
            _ = try JSONDecoder().decode(UpdateArticleResponse.self, from: data)
            try await self.fetch()
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
    
    public func remove(_ items: [Article]) async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        let request = DeleteArticleRequest(
            accessToken: currentUser.accessToken,
            articleIds: items.map({ String($0.id) })
        )
        let result = await api.request(by: request)
        
        switch result {
        case .success(_):
            try await self.fetch()
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
    
    public func search(_ keyword: String) async -> [Article] {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return []
        }
        let request = SearchArticleRequest(
            accessToken: currentUser.accessToken,
            search: keyword
        )
        let result = await api.request(by: request)
        
        do {
            switch result {
                case .success(let data):
                    let response = try JSONDecoder().decode(SearchArticleResponse.self, from: data)
                    return response.articles.map({
                        ArticleData(
                            id: $0.id,
                            title: $0.title,
                            url: $0.url,
                            imageUrl: "",
                            content: $0.content,
                            isPublic: $0.isPublic,
                            viewCount: $0.viewCount,
                            createdAt: $0.createdAt,
                            updatedAt: $0.updatedAt,
                            tagIds: $0.tagIds
                        )
                    })
                case .failure(let error):
                    print(error.description)
                    return []
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
}
