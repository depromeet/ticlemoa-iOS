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
             isPublic: true, tagIds: [], created: "2022-02-16T09:15:08.034Z"),
            (title: "홍대삭", url: "https://zazak.tistory.com/3035",
             isPublic: false, tagIds: [], created: "2022-02-16T09:15:08.034Z"),
            (title: "자가제면홍제우동", url: "https://m.blog.naver.com/ye_onny/222671614005",
             isPublic: true, tagIds: [], created: "2022-04-16T09:15:08.034Z"),
            (title: "우동가조쿠", url: "https://m.blog.naver.com/ock9ock9/221319743409", isPublic: true, tagIds: [], created: "2022-05-16T09:15:08.034Z"),
            (title: "시장맥주", url: "https://m.blog.naver.com/yuuun__is/221381716835", isPublic: true, tagIds: [], created: "2022-06-16T09:15:08.034Z"),
            (title: "버거인뉴욕", url: "https://m.blog.naver.com/ekwjd3011/221482432534", isPublic: false, tagIds: [], created: "2022-07-16T09:15:08.034Z"),
            (title: "사대부집 곳간", url: "https://m.blog.naver.com/reve8612/222860100908", isPublic: true, tagIds: [], created: "2022-09-16T09:15:08.034Z"),
            (title: "창고43", url: "https://pinksoap.tistory.com/507", isPublic: true, tagIds: [], created: "2022-10-16T09:15:08.034Z"),
            (title: "연어롭다", url: "https://m.blog.naver.com/icecream0514/222694311739", isPublic: true, tagIds: [], created: "2022-11-16T09:15:08.034Z"),
            (title: "라이카 시네마", url: "http://laikacinema.com/about", isPublic: true, tagIds: [], created: "2022-12-16T09:15:08.034Z"),
            (title: "히츠지야", url: "https://m.blog.naver.com/shinemrk/221646591105", isPublic: true, tagIds: [], created: "2023-01-16T09:15:08.034Z"),
            (title: "신촌 여수집", url: "https://m.blog.naver.com/sielle83/221491184817", isPublic: true, tagIds: [], created: "2023-02-16T09:15:08.034Z"),
            (title: "애플", url: "https://www.apple.com", isPublic: true, tagIds: [], created: "2023-03-16T09:15:08.034Z"),
            (title: "디자이너와 프로그래머가 만났을 때", url: "https://www.depromeet.com", isPublic: true, tagIds: [], created: "2023-04-16T09:15:08.034Z"),
            (title: "F-rame 편집샵", url: "https://f-rame.com", isPublic: true, tagIds: [], created: "2023-04-16T09:15:08.034Z"),
        ].enumerated().map({
            .init(
                id: $0.offset, title: $0.element.title, url: $0.element.url, content: "링크 \($0.offset) 내용", isPublic: $0.element.isPublic, tagIds: $0.element.tagIds, created: $0.element.created)
        })
    }
}

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
    
    public var itemsPublisher: Published<[Article]>.Publisher { $items }
    
    @Published private var items: [Article] = ArticleData.dummy
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
