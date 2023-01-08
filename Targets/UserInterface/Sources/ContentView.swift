//
//  ContentView.swift
//  UserInterface
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import DomainInterface

import SwiftUI

public struct ContentView: View {
    @State private var isLoggedIn: Bool = false // MARK: AppStore? UserDefault?
    @EnvironmentObject var modelContainer: ModelContainer
    
    public init() { }
    
    public var body: some View {
        Group {
            if isLoggedIn {
                MainTabView()
                    .transition(.scale)
            } else {
                LoginView(
                    viewModel: LoginViewModel(
                        modelContainer: modelContainer
                    ),
                    isLoggedIn: $isLoggedIn
                )
                    .transition(.scale)
                
            }
        }
    }
    
}

#if DEBUG

struct MockTag: Tag {
    var id: Int
    var userId: Int
    var tagName: String
}

struct MockArticle: Article {
    var id: Int
    var title: String
    var url: String
    var content: String
    var isPublic: Bool
    var tagIds: [Int]
    var created: String
}

struct MockLoginUser: LoginUser {
    var userId: Int? = 1
    var nickName: String = ""
    var accessToken: String?
}

final class MockArticleModel: ArticleModelProtocol {
    @Published var items: [DomainInterface.Article] = []
    var itemsPublisher: Published<[DomainInterface.Article]>.Publisher { $items }

    func fetch() { }
    func create(_ item: DomainInterface.Article) { }
    func read(_ item: DomainInterface.Article) { }
    func update(_ item: DomainInterface.Article) async { }
    func remove(_ item: DomainInterface.Article) { }
}

final class MockTagModel: TagModelProtocol {
    @Published var items: [DomainInterface.Tag] = []
    var itemsPublisher: Published<[DomainInterface.Tag]>.Publisher { $items }
    
    func fetch() { }
    func create(tagName: String) async throws {}
    func read(page: Int, take: Int) async throws {}
    func update(tagId: Int, tagName: String) async throws {}
    func remove(tagId: Int) async throws {}
}

final class MockLoginModel: LoginModelProtocol {
    func isKakaoTalkLoginUrl(_ url: URL) -> Bool {
        return true //FIXME: 다른 pr에서 수정 예정
    }
    
    func authController(url: URL) -> Bool {
        return true //FIXME: 다른 pr에서 수정 예정
    }
    
    @Published var userData: LoginUser = MockLoginUser()
    var userDataPublisher: Published<DomainInterface.LoginUser>.Publisher { $userData }
    
    func checkKakaoLogin() async -> Bool { false }
}

#endif
