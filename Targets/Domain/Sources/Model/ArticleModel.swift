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

extension ArticleData {
    static var dummy: [Self] {
        [
            (title: "우육면관", url: "https://m.blog.naver.com/hjy6005/222428005687",
             isPublic: true, tagIds: [], createdAt: "2022-02-16T09:15:08.034Z"),
            (title: "홍대삭", url: "https://zazak.tistory.com/3035",
             isPublic: false, tagIds: [], createdAt: "2022-02-16T09:15:08.034Z"),
            (title: "자가제면홍제우동", url: "https://m.blog.naver.com/ye_onny/222671614005",
             isPublic: true, tagIds: [], createdAt: "2022-04-16T09:15:08.034Z"),
            (title: "우동가조쿠", url: "https://m.blog.naver.com/ock9ock9/221319743409",
             isPublic: true, tagIds: [], createdAt: "2022-05-16T09:15:08.034Z"),
            (title: "시장맥주", url: "https://m.blog.naver.com/yuuun__is/221381716835",
             isPublic: true, tagIds: [], createdAt: "2022-06-16T09:15:08.034Z"),
            (title: "버거인뉴욕", url: "https://m.blog.naver.com/ekwjd3011/221482432534",
             isPublic: false, tagIds: [], createdAt: "2022-07-16T09:15:08.034Z"),
            (title: "사대부집 곳간", url: "https://m.blog.naver.com/reve8612/222860100908",
             isPublic: true, tagIds: [], createdAt: "2022-09-16T09:15:08.034Z"),
            (title: "창고43", url: "https://pinksoap.tistory.com/507",
             isPublic: true, tagIds: [], createdAt: "2022-10-16T09:15:08.034Z"),
            (title: "연어롭다", url: "https://m.blog.naver.com/icecream0514/222694311739",
             isPublic: true, tagIds: [], createdAt: "2022-11-16T09:15:08.034Z"),
            (title: "라이카 시네마", url: "http://laikacinema.com/about",
             isPublic: true, tagIds: [], createdAt: "2022-12-16T09:15:08.034Z"),
            (title: "히츠지야", url: "https://m.blog.naver.com/shinemrk/221646591105",
             isPublic: true, tagIds: [], createdAt: "2023-01-16T09:15:08.034Z"),
            (title: "신촌 여수집", url: "https://m.blog.naver.com/sielle83/221491184817",
             isPublic: true, tagIds: [], createdAt: "2023-02-16T09:15:08.034Z"),
            (title: "애플", url: "https://www.apple.com",
             isPublic: true, tagIds: [], createdAt: "2023-03-16T09:15:08.034Z"),
            (title: "디자이너와 프로그래머가 만났을 때", url: "https://www.depromeet.com",
             isPublic: true, tagIds: [], createdAt: "2023-04-16T09:15:08.034Z"),
            (title: "F-rame 편집샵", url: "https://f-rame.com",
             isPublic: true, tagIds: [], createdAt: "2023-04-16T09:15:08.034Z"),
        ].enumerated().map({
            .init(
                id: $0.offset, title: $0.element.title, url: $0.element.url, content: "링크 \($0.offset) 내용", isPublic: $0.element.isPublic, viewCount: 0, createdAt: $0.element.createdAt, updatedAt: "")
        })
    }
}

public final class ArticleModel: ArticleModelProtocol {
    
    public var itemsPublisher: Published<[Article]>.Publisher { $items }
    
    @Published private var items: [Article] = ArticleData.dummy
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
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
    
    public func fetch() async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        let request = ReadArticleRequest(
            accessToken: currentUser.accessToken,
            userId: currentUser.userId
        )
        let result = await api.request(by: request)
            
        switch result {
        case .success(let data):
            let response = try JSONDecoder().decode(ReadArticleResponse.self, from: data)
            self.items = response.articles.map({
                ArticleData(
                    id: $0.id,
                    title: $0.title,
                    url: $0.url,
                    content: $0.content,
                    isPublic: $0.isPublic,
                    viewCount: $0.viewCount,
                    createdAt: $0.createdAt,
                    updatedAt: $0.updatedAt
                )
            })
        case .failure(let network):
            throw DomainInterfaceError.networkError(code: network.code)
        }
    }
    
    public func update(_ item: Article) async throws {
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
                tagIds: []
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
    
    public func search(_ keyword: String) async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        let request = SearchArticleRequest(
            accessToken: currentUser.accessToken,
            search: keyword
        )
        let result = await api.request(by: request)
        
        switch result {
        case .success(let data):
            let response = try JSONDecoder().decode(SearchArticleResponse.self, from: data)
            self.items = response.articles.map({
                ArticleData(
                    id: $0.id,
                    title: $0.title,
                    url: $0.url,
                    content: $0.content,
                    isPublic: $0.isPublic,
                    viewCount: $0.viewCount,
                    createdAt: $0.createdAt,
                    updatedAt: $0.updatedAt
                )
            })
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
    
}
