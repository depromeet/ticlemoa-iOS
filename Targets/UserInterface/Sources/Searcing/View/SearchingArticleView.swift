//
//  SearchingArticleView.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/12/15.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct SearchingArticleView: View {
    @State private var searchQuery: String = ""
    @ObservedObject private var viewModel: SearchingArticleViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(recentQueries: [String]) {
        self.viewModel = SearchingArticleViewModel(recentQueries: recentQueries)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                HStack(spacing: 16.19) {
                    Button {
                        dismiss()
                    } label: {
                        Image("arrow")
                    }
                    searchBar
                }
                .padding(.leading, 24.52)
                .padding(.trailing, 20)
                if searchQuery.isEmpty {
                    recentQueryList
                } else {
                    articleList
                }
                Spacer()
            }
            if viewModel.recentQueries.isEmpty && searchQuery.isEmpty {
                Text("최근 검색어가 없습니다.")
                    .font(.system(size: 14))
                    .foregroundColor(.grey4)
            }
        }
        .hideKeyboard()
    }
}

extension SearchingArticleView {
    var searchBar: some View {
        HStack(spacing: 0) {
            Image("search")
                .padding(.leading, 11.5)
            TextField("", text: $searchQuery)
                .placeholder("검색어를 입력해주세요", when: searchQuery.isEmpty, color: .grey3)
                .font(.system(size: 14))
                .padding(.leading, 6.11)
                .submitLabel(.done)
            if !searchQuery.isEmpty {
                Button {
                    searchQuery = ""
                } label: {
                    Image("ClearButtonGreyLine2")
                        .frame(width: 16.5, height: 16.5)
                        .padding(.leading, 8.75)
                        .padding(.trailing, 12.75)
                }
            }
        }
        .frame(height: 42)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.grey2Line, lineWidth: 1)
        )
    }
    
    var recentQueryList: some View {
        VStack(spacing: 0) {
            HStack{
                Text("최근 검색어")
                    .font(.system(size: 14))
                Spacer()
                Button {
                    viewModel.recentQueries.removeAll()
                } label: {
                    Text("전체삭제")
                        .foregroundColor(.grey3)
                        .font(.system(size: 12))
                }
            }
            .padding(.horizontal, 20)
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.recentQueries, id: \.self) { recentQuery in
                        recentQueryView(recentQueries: $viewModel.recentQueries, query: recentQuery)
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    var articleList: some View {
        VStack(spacing: 0) {
            HStack {
                Text("총 \(4)개의 검색결과")
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(.leading, 20)
            
            // FIXME: 일단 HomeView의 HomeArticleList와 동일하게 구현, 추후에 ArticleRow 수정에 따라 변경 예정
            List {
//                ArticleRow()
//                ArticleRow()
//                ArticleRow()
//                ArticleRow()
//                ArticleRow()
            }
            .listStyle(.plain)
            .frame(maxWidth: .infinity)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

private struct recentQueryView: View {
    @Binding var recentQueries: [String]
    let query: String
    
    var body: some View {
        HStack(spacing: 0) {
            Image("recent")
                .frame(width: 14, height: 14)
            Text(query)
                .font(.system(size: 16))
                .padding(.leading, 9)
            Spacer()
            Button {
                recentQueries = recentQueries.filter({ $0 != query })
            } label: {
                Image("deleteButton")
                    .frame(width: 10.5, height: 10.5)
            }
        }
        .frame(height: 56)
        .padding(.leading, 23)
        .padding(.trailing, 21.75)
    }
}

struct SearchingArticleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingArticleView(recentQueries: ["서비스기획", "더블다이아몬드", "UX 방법론"])
    }
}
