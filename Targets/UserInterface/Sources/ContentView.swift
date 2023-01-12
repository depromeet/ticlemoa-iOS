//
//  ContentView.swift
//  UserInterface
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import DomainInterface
import SwiftUI


public class ContentViewModel: ObservableObject {
    @Published var isLoggedIn: LoginUser? = nil
    @ObservedObject var modelContainer: ModelContainer
    
    public init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
            
        modelContainer
            .loginModel
            .userDataPublisher
            .receive(on: RunLoop.main)
            .assign(to: &self.$isLoggedIn)
    }
    
}

public struct ContentView: View {
    @EnvironmentObject var modelContainer: ModelContainer
    @ObservedObject var viewModel: ContentViewModel
    
    public init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Group {
            if viewModel.isLoggedIn != nil {
                MainTabView()
                    .transition(.scale)
            } else {
                LoginView(viewModel: .init(modelContainer: modelContainer))
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
    var imageUrl: String = ""
    var id: Int = 0
    var title: String = "테스트 아티클 제목"
    var url: String = ""
    var content: String = "테스트 아티클"
    var isPublic: Bool = false
    var tagIds: [Int] = []
    var viewCount: Int = 0
    var createdAt: String = "2023/01/12"
    var updatedAt: String = "2023/01/12"
}

struct MockLoginUser: LoginUser {
    var userId: Int = 1
    var nickName: String = ""
    var accessToken: String
    var mail: String
}

final class MockArticleModel: ArticleModelProtocol {
    @Published var items: [DomainInterface.Article] = [MockArticle(imageUrl: "", id: 1, title: "테스트입니다.", url: "www.naver.com", content: "테스트입니다.", isPublic: false, tagIds: [1, 2], viewCount: 0, createdAt: "", updatedAt: "")]
    var itemsPublisher: Published<[DomainInterface.Article]>.Publisher { $items }
    func fetch(tagId: Int?) async throws {}
    func update(_ item: DomainInterface.Article, tagIds: [Int]) async throws {}
    func create(_ item: DomainInterface.Article, tagIds: [Int]) async { }
    func remove(_ items: [DomainInterface.Article]) async throws {}
    func search(_ keyword: String) async -> [Article] { [] }
}

final class MockTagModel: TagModelProtocol {
    @Published var items: [DomainInterface.Tag] = []
    var itemsPublisher: Published<[DomainInterface.Tag]>.Publisher { $items }
    
    func fetch() { }
    func create(tagName: String) async throws {}
    func read() async throws {}
    func update(tagId: Int, tagName: String) async throws {}
    func remove(tagId: Int) async throws {}
}

final class MockLoginModel: LoginModelProtocol {
    var isLoggedIn: Bool { false }
    
    func deleteAccount() async -> Bool {
        return false
    }
    
    func nicknameChangeTo(_ nickname: String) {
        Void()
    }
    
    @Published var userData: LoginUser? = MockLoginUser(
        userId: 0, nickName: "TestNickname", accessToken: "", mail: "ticlemoa@gmail.com"
    )
    var userDataPublisher: Published<DomainInterface.LoginUser?>.Publisher { $userData }
    func requestAccessToken() async -> Bool { true }
    func checkKakaoLogin() async -> Bool { false }
    func isKakaoTalkLoginUrl(_ url: URL) -> Bool { return true }
    func authController(url: URL) -> Bool { return true }
}

#endif
