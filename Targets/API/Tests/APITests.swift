//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import XCTest
@testable import API

extension APITests {
    var accessToken: String { URLStrings.adminAccesstoken }
    var userId: Int { 1 }
}

final class APITests: XCTestCase {
    var sut: APIDetails!
        
    override func setUp() {
        self.sut = TiclemoaAPI()
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    func test_ticlemoaAPI_request() async {
        // given
        let request = ReadArticleRequest(accessToken: accessToken, userId: userId)
        // when
        let result = await self.sut.request(by: request)
        
        var success: Bool
        switch result {
            case .success(_): success = true
            case .failure(_): success = false
        }
        
        // then
        XCTAssertTrue(success)
    }
    
}

// MARK: - Article Request / Response
/*
    사용자 정보 userId = 0
    
    article 의 id 넣어서 각 테스트 가능
    delete 테스트는 id를 확인 후 주석 해제하고 테스트
 */
extension APITests {
    
    func test_createArticle() async {
        // given
        let newItem = CreateArticleRequest.Body.init(
            content: "테스트 용 업로드",
            userId: userId,
            title: "김용우 블로그",
            url: "https://keeplo.tistory.com/",
            isPublic: false,
            tagIds: []
        )
        let request = CreateArticleRequest(accessToken: accessToken, body: newItem)
        // when
        let result = await self.sut.request(by: request)
        if case .success(let data) = result {
            let response = try? JSONDecoder().decode(CreateArticleResponse.self, from: data)

        // then
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
        } else {
            XCTAssertTrue(false)
        }

    }

    func test_readArticle() async {
        // given
        let request = ReadArticleRequest(accessToken: accessToken, userId: userId)
        // when
        let result = await self.sut.request(by: request)
        if case .success(let data) = result {
            let response = try? JSONDecoder().decode(ReadArticleResponse.self, from: data)
            
        // then
            XCTAssertNotNil(data)
            XCTAssertTrue(response!.articles.count > 10)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func test_uploadArticle() async {
        // given
        let editedTitle = "김용우 블로그"
        let request = UpdateArticleRequest(
            accessToken: accessToken,
            articleId: 41,
            body: .init(
                content: "테스트 블로그",
                userId: 1,
                title: editedTitle,
                url: "https://keeplo.tistory.com/",
                isPublic: false,
                tagIds: []
            )
        )
        // when
        let result = await self.sut.request(by: request)

        if case .success(let data) = result {
            let response = try? JSONDecoder().decode(UpdateArticleResponse.self, from: data)

        // then
            XCTAssertNotNil(data)
            XCTAssertEqual(response!.title, editedTitle)
        } else {
            XCTAssertTrue(false)
        }
    }
    
//    func test_deleteArticle() async {
//        // given
//        let request = DeleteArticleRequest(accessToken: accessToken, articleIds: [
//            "\(31)"
//        ])
//        // when
//        let result = await self.sut.request(by: request)
//        if case .success(let data) = result {
//
//        // then
//            XCTAssertNotNil(data)
//        } else {
//            XCTAssertTrue(false)
//        }
//    }

    func test_searchArticle() async {
        // given
        let request = SearchArticleRequest(accessToken: accessToken, search: "1")
        // when
        let result = await self.sut.request(by: request)
        if case .success(let data) = result {
            let response = try? JSONDecoder().decode(SearchArticleResponse.self, from: data)
            
        // then
            XCTAssertNotNil(data)
            XCTAssertTrue(response!.articles.count > 2)
        } else {
            XCTAssertTrue(false)
        }
    }
}

/* MARK: - Tag Request / Response
 tagId는 test_readTag를 통해 확인 후 직접 기입
 */

extension APITests {
    func test_createTag() async {
        // given
        let newItem = CreateTagRequest.Body(tagName: "차요셉 태그")
        let request = CreateTagRequest(accessToken: accessToken, body: newItem)
        
        // when
        let result = await self.sut.request(by: request)
        if case .success(let data) = result {
        // then
            XCTAssertNotNil(data)
        } else {
            XCTAssertTrue(false)
        }

    }
    
    func test_readTag() async {
        // given
        let request = ReadTagRequest(accessToken: accessToken, page: 1, take: 1)
        
        // when
        let result = await self.sut.request(by: request)
        if case .success(let data) = result {
            let response = try? JSONDecoder().decode(ReadTagResponse.self, from: data)

        // then
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func test_updateTag() async {
        // given
        let newItem = UpdateTagRequest.Body(tagName: "차요셉 태그")
        let request = UpdateTagRequest(accessToken: accessToken, tagId: 1, body: newItem) // TODO: tagId는 test_readTag를 통해 확인 후 직접 기입
        
        // when
        let result = await self.sut.request(by: request)
        if case .success(let data) = result {

        // then
            XCTAssertNotNil(data)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func test_deleteTag() async {
        // given
        let request = DeleteTagRequest(accessToken: accessToken, tagId: 1) // TODO: tagId는 test_readTag를 통해 확인 후 직접 기입
        
        // when
        let result = await self.sut.request(by: request)
        var success: Bool
        switch result {
            case .success(_): success = true
            case .failure(_): success = false
        }
        
        // then
        XCTAssertTrue(success)
        
    }
}
