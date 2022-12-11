//
//  HomeArticleList.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct HomeArticleList: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        List {
            ForEach(
                Array(viewModel.groupArticlesByMonth(articles: Article.allArticles)).reversed(),id: \.key) { month, articles in
                    Section {
                        ForEach(articles) { article in
                            ArticleRow(title: article.title)
                        }
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity)
    }
}

struct HomeArticleList_Previews: PreviewProvider {
    static let homeViewModel: HomeViewModel = {
        let vm = HomeViewModel()
        vm.articles = Article.allArticles
        return vm
    }()
    
    static var previews: some View {
        HomeArticleList()
            .environmentObject(homeViewModel)
    }
}
