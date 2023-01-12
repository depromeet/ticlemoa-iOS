//
//  SearchingArticleViewModel.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import DomainInterface
import Combine

final class SearchingArticleViewModel: ObservableObject {
    
    enum State {
        case idle
        case searched([Article])
    }
    
    @ObservedObject var modelContainer: ModelContainer
    @Published var state: State = .idle
    @Published var searchQuery: String = ""
    @Published var loginUser: LoginUser?
    @Published var recentQueries: [String] = (UserDefaults.standard
        .array(forKey: "searchQueries") as? [String] ?? []
    ) {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "searchQueries")
        }
    }
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        
        modelContainer.loginModel.userDataPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] loginUser in
                if let user = loginUser {
                    self?.loginUser = user
                } else {
                    self?.recentQueries = []
                }
            }
            .store(in: &cancellableSet)
    }
    
}

extension SearchingArticleViewModel {
    
    func submit(by query: String? = nil) async -> String? {
        self.state = .idle
        guard let checkedQuery = checkQuery(by: query) else { return nil }
        await self.search(by: checkedQuery)
        return checkedQuery
    }

}

extension SearchingArticleViewModel {
    
    private func search(by query: String) async {
        let result = await self.modelContainer.articleModel.search(query)
        self.state = .searched(result)
    }
    
    private func checkQuery(by query: String? = nil) -> String? {
        if let keyword = query,
           !keyword.filter({ $0 != " " }).isEmpty
        {
            return keyword
        } else if !searchQuery.filter({ $0 != " " }).isEmpty {
            return self.searchQuery
        } else {
            return nil
        }
    }
    
}

