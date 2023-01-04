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
    
    public init() { }
    
    public var body: some View {
        Group {
            if isLoggedIn {
                MainTabView()
                    .transition(.scale)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .transition(.scale)
                
            }
        }
    }
    
}

#if DEBUG

final class MockArticleModel: ArticleModelProtocol {
    var items: [DomainInterface.Article] = []
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
    @Published var items: String?
    var accessTokenPublisher: Published<String?>.Publisher { $items }
    
    func requestKakaoLogin(_ accessToken: String) async -> Bool { true }
}

#endif
