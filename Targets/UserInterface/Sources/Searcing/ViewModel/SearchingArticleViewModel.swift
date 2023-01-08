//
//  SearchingArticleViewModel.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

final class SearchingArticleViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
}

