//
//  HomeArticleList.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

import DomainInterface

struct HomeArticleList: View {
    @EnvironmentObject var modelContainer: ModelContainer
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Divider()
            Group {
                if !viewModel.articles.isEmpty {
                    HStack {
                        NavigationLink {
                            SearchingArticleView(viewModel: .init(modelContainer: modelContainer))
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            HStack {
                                Image("glass_icon")
//                                    .pretendFont(.title3)
                                Text("검색")
                                    .customFont(weight: 700, size: 14, lineHeight: 21)
                                    .foregroundColor(Color.ticlemoaBlack)
                            }
                            .background { Color.grey1 }
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                        }
                        Spacer()
                        Button(
                            action: {
                                withAnimation {
                                    if (viewModel.filterType == FilterType.createdBy) {
                                        viewModel.filterType = FilterType.popularBy
                                        return
                                    }
                                    viewModel.filterType = FilterType.createdBy
                                }
                            }, label: {
                                HStack {
                                    // MARK: Menu 제안
                                    Text(viewModel.filterType == FilterType.createdBy
                                         ? FilterType.createdBy.rawValue
                                         : FilterType.popularBy.rawValue
                                    )
                                    .customFont(weight: 700, size: 14, lineHeight: 21)
                                    .animation(.default)
                                    .foregroundColor(Color.ticlemoaBlack)
                                    Image("up_down_icon")
                                        .padding(.trailing, 20)
                                }
                            }
                        )
                    }
                    
                    Divider()
                    
                    ScrollView {
                        VStack {
                            ForEach(
                                Array(viewModel.groupArticlesByMonth(articles: viewModel.articles)).reversed(),id: \.key) { month, groupedArticles in
                                    Section {
                                        HStack {
                                            Text(month)
                                                .pretendFont(.title3)
                                            Spacer()
                                        }
                                        .padding(.leading, 20)
                                        .padding(.top, 12)
                                        .listRowBackground(Color.grey1)
                                        
                                        ForEach(groupedArticles) { groupedArticle in
                                            ArticleRow(
                                                modelContainer: modelContainer,
                                                article: groupedArticle.article
                                            )
                                            .onTapGesture {
                                                if let url = URL(string: groupedArticle.article.url) {
                                                    UIApplication.shared.open(url, options: [:])
                                                }
                                            }
                                        }
                                    }
                                    .listSectionSeparator(.hidden)
                                }
                        }
                    }
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        Image("home_empty_view")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 141.08)
                        
                        Text("아직 아티클이 없어요")
                            .foregroundColor(.grey4)
                            .customFont(weight: 400, size: 14, lineHeight: 21, style: .medium)
                        Spacer()
                    }.background(Color.grey1)
                    
                }
            }
        }
    }
}


struct HomeArticleList_Previews: PreviewProvider {
    static var previews: some View {
        HomeArticleList(viewModel: .init(modelContainer: .dummy))
    }
}
