//
//  HomeArticleList.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct HomeArticleList: View {
    @EnvironmentObject var modelContainer: ModelContainer
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                NavigationLink {
                    SearchingArticleView(viewModel: .init(modelContainer: modelContainer))
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .pretendFont(.title3)
                        Text("검색")
                            .pretendFont(.title1)
                            .foregroundColor(Color.ticlemoaBlack)
                    }
                    .background { Color.grey1 }
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                }
                Spacer()
                Button(
                    action: {
                        
                    }, label: {
                        Text("최신순")  // MARK: Menu 제안
                            .pretendFont(.title1)
                            .foregroundColor(Color.ticlemoaBlack)
                    }
                )
            }
            Divider()
            
            List {
                ForEach(
                    Array(viewModel.groupArticlesByMonth(articles: TemporaryArticle.allArticles)).reversed(),id: \.key) { month, articles in
                        Section {
                            HStack {
                                Text(month)
                                    .pretendFont(.title3)
                                Spacer()
                            }
                            .listRowBackground(Color.grey1)
                            
                            ForEach(articles) { article in
                                ArticleRow(title: article.title, imageURLString: article.imageURLString)
                                    .onTapGesture {
                                        if let url = URL(string: article.urlString) {
                                            UIApplication.shared.open(url, options: [:])
                                        }
                                    }
                            }
                        }
                        .listSectionSeparator(.hidden)
                    }
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity)
        }
    }
}

struct HomeArticleList_Previews: PreviewProvider {
    static var previews: some View {
        HomeArticleList(viewModel: .init(modelContainer: .dummy))
    }
}
