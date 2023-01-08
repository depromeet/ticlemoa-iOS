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
    @Binding var isNotEmptyArticle: Bool
    
    
    var body: some View {
        VStack {
            Divider()

            
            Group {
                if !isNotEmptyArticle {
                    
                    NavigationLink {
                        // TODO: 검색 화면으로 이동
                    } label: {
                        HStack {
                            Image("glass_icon")
                                .pretendFont(.title3)
                            Text("검색")
                                .customFont(weight: 700, size: 14, lineHeight: 21, style: .bold)
                                .foregroundColor(Color.ticlemoaBlack)
                            
                            Spacer()
                            Group {
                                Text((viewModel.filterType.rawValue))
                                    .customFont(weight: 700, size: 14, lineHeight: 21, style: .bold)
                                    .foregroundColor(Color.ticlemoaBlack)
                                Image("filter_icon")
                            }
                            .onTapGesture {
                                if (viewModel.filterType == .createdBy) {
                                    viewModel.filterType = .popularBy
                                } else {
                                    viewModel.filterType = .createdBy
                                }
                                
                            }
                        }
                        .background { Color.grey1 }
                        .foregroundColor(.black)
                        .padding(.horizontal, 21)
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

//struct HomeArticleList_Previews: PreviewProvider {
//    static let homeViewModel: HomeViewModel = {
//        let vm = HomeViewModel(
//            modelContainer: ModelContainer(
//                articleModel: MockArticleModel(),
//                tagModel: MockTagModel(),
//                loginModel: MockLoginModel()
//            )
//        )
//        vm.articles = TemporaryArticle.allArticles
//        return vm
//    }()
//    
//    static var previews: some View {
//        HomeArticleList()
//            .environmentObject(homeViewModel)
//    }
//}
