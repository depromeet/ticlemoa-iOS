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
    @EnvironmentObject var modelContainer: ModelContainer
    @State private var isLoggedIn: Bool = false // MARK: AppStore? UserDefault?
    
    public init() { }
    
    public var body: some View {
        Group {
            if isLoggedIn {
                MainTabView()
                    .transition(.scale)
            } else {
                LoginView(
                    viewModel: .init(modelContainer: modelContainer),
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
    var name: String
    var created: String
}

struct MockArticle: Article {
    var id: Int
    var title: String
    var url: String
    var content: String
    var isPublic: Bool
    var tagIds: [Int]
    var viewCount: Int
    var createdAt: String
    var updatedAt: String
}

struct MockLoginUser: LoginUser {
    var nickName: String = ""
    var accessToken: String?
    var userId: Int?
    var mail: String
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
    func create(_ item: DomainInterface.Tag) { }
    func read(_ item: DomainInterface.Tag) { }
    func update(_ item: DomainInterface.Tag) { }
    func remove(_ item: DomainInterface.Tag) { }
}

final class MockLoginModel: LoginModelProtocol {
    @Published var userData: LoginUser? = MockLoginUser(mail: "ticlemoa@gmail.com")
    var userDataPublisher: Published<DomainInterface.LoginUser?>.Publisher { $userData }
    
    func checkKakaoLogin() async -> Bool { false }
    func isKakaoTalkLoginUrl(_ url: URL) -> Bool { return true }
    func authController(url: URL) -> Bool { return true }
}

#endif
