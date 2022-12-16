//
//  SearchingArticleViewModel.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

final class SearchingArticleViewModel: ObservableObject {
    @Published var recentQueries: [String]
    
    init(recentQueries: [String]) {
        self.recentQueries = recentQueries
    }
}

