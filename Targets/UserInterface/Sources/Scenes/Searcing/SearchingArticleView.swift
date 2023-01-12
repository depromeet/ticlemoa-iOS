//
//  SearchingArticleView.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/12/15.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct SearchingArticleView: View {
    @ObservedObject var viewModel: SearchingArticleViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    init(viewModel: SearchingArticleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                searchBar
                if case let .searched(items) = viewModel.state {
                    if items.isEmpty {
                        Spacer()
                        Image("Nothing")
                        Text("검색 결과가 없습니다")
                            .font(.system(size: 14))
                            .foregroundColor(.grey4)
                    } else {
                        VStack(spacing: 0) {
                            HStack {
                                Text("총 \(items.count)개의 검색결과")
                                    .font(.system(size: 14))
                                Spacer()
                            }
                            .padding(.leading, 20)
                            List {
                                ForEach(items, id: \.id) { item in
                                    ArticleRow(article: item)
                                }
                            }
                            .listStyle(.plain)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                UIApplication.shared.sendAction(
                                    #selector(UIResponder.resignFirstResponder),
                                    to: nil,
                                    from: nil,
                                    for: nil
                                )
                            }
                        }
                    }
                } else {
                    if viewModel.recentQueries.isEmpty {
                        Spacer()
                        Image("Nothing")
                        Text("최근 검색어가 없습니다")
                            .font(.system(size: 14))
                            .foregroundColor(.grey4)
                    } else {
                        recentQueryList
                    }
                }
                Spacer()
            }
        }
        .setupBackground()
        .hideKeyboard()
        .onChange(of: viewModel.searchQuery) { searchQuery in
            if searchQuery.isEmpty {
                viewModel.state = .idle
            }
        }
        .onAppear {
            _ = self.viewModel.recentQueries
        }
        // MARK: 자동검색 (검색어 입력 후 3초 뒤 요청) - 중복 제어 필요
//        .onReceive(viewModel.$searchQuery.debounce(for: 3, scheduler: RunLoop.main)) { query in
//            Task {
//                guard let searchedQuery = await self.viewModel.submit(by: query) else { return }
//                self.recentQueries.insert(searchedQuery, at: 0)
//            }
//        }
    }
}

extension SearchingArticleView {
    
    var searchBar: some View {
        HStack(spacing: 16.19) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image("arrow")
            }
            HStack(spacing: 0) {
                Image("search")
                    .padding(.leading, 11.5)
                TextField("", text: $viewModel.searchQuery)
                    .placeholder(
                        "검색어를 입력해주세요",
                        when: viewModel.searchQuery.isEmpty,
                        color: .grey3
                    )
                    .font(.system(size: 14))
                    .padding(.leading, 6.11)
                    .submitLabel(.done)
                    .onSubmit {
                        Task {
                            guard let searchedQuery = await self.viewModel.submit() else { return }
                            self.viewModel.recentQueries.insert(searchedQuery, at: 0)
                        }
                    }
                if !viewModel.searchQuery.isEmpty {
                    Button {
                        viewModel.searchQuery = ""
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
        .padding(.leading, 24.52)
        .padding(.trailing, 20)
    }
    
    var recentQueryList: some View {
        VStack(spacing: 0) {
            HStack{
                Text("최근 검색어")
                    .font(.system(size: 14))
                Spacer()
                Button {
                    self.viewModel.recentQueries = []
                } label: {
                    Text("전체삭제")
                        .foregroundColor(.grey3)
                        .font(.system(size: 12))
                }
            }
            .padding([.horizontal, .bottom], 20)
            ScrollView {
                LazyVStack {
                    ForEach(Array(zip(viewModel.recentQueries.indices, viewModel.recentQueries)), id: \.0) { index, recentQuery in
                        RecentQueryRow(
                            recentQuery: recentQuery,
                            searchAction: { selectedQuery in
                                Task {
                                    guard let searchedQuery = await self.viewModel.submit(by: selectedQuery) else { return }
                                    self.viewModel.recentQueries.insert(searchedQuery, at: 0)
                                }
                            },
                            removeAction: { self.viewModel.recentQueries.remove(at: index) }
                        )
                        .listRowBackground(Color.clear)
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
}

struct SearchingArticleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingArticleView(viewModel: .init(modelContainer: .dummy))
    }
}
