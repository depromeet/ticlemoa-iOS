//
//  ArticleManagingListView.swift
//  UserInterface
//
//  Created by Joseph Cha on 2023/01/13.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI
import Combine

import DomainInterface

struct CheckableArticle: Identifiable {
    let id: Int
    let article: Article
    var isSelected: Bool = false
}

struct ArticleManagingListView: View {
    @EnvironmentObject private var modelContainer: ModelContainer
    @State private var chekableArticles: [CheckableArticle] = []
    @State private var isArticlesDeletingButtonTouched: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    let tag: Tag
    var cancellableSet: Set<AnyCancellable> = []
    
    var body: some View {
        VStack(spacing: 0) {
            if chekableArticles.isEmpty {
                Image("article_empty")
                    .frame(width: 335, height: 188)
            } else {
                articleList
                deleteButton
            }
        }
        .ticlemoaNavigationBar(title: tag.tagName, image: "arrow") {
            if !chekableArticles.isEmpty {
                Button {
                    self.chekableArticles = self.chekableArticles.map {
                        CheckableArticle(
                            id: $0.id,
                            article: $0.article,
                            isSelected: true
                        )
                    }
                } label: {
                    Text("전체선택")
                        .customFont(weight: 400, size: 16, lineHeight: 20)
                        .foregroundColor(.ticlemoaBlack)
                }
            }
        }
        .toast(message: toastMessage,
               isShowing: $showToast,
               duration: Toast.short)
        .onReceive(self.modelContainer.articleModel.itemsPublisher) { articles in
            self.chekableArticles = articles
                .filter { $0.tagIds.contains(tag.id) }
                .map {
                    CheckableArticle(
                        id: $0.id,
                        article: $0
                    )
                }
        }
    }
}

extension ArticleManagingListView {
    var articleList: some View {
        ScrollView {
            ForEach($chekableArticles, id: \.id) { $chekableArticle in
                ArticleManagingListRow(checkableArticle: $chekableArticle)
            }
        }
    }
    
    var deleteButton: some View {
        Button {
            isArticlesDeletingButtonTouched = true
        } label: {
            Text("삭제")
                .customFont(weight: 600, size: 12, lineHeight: 18)
                .foregroundColor(chekableArticles.filter{$0.isSelected}.isEmpty ? .grey4 : .white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
        }
        .disabled(chekableArticles.filter{$0.isSelected}.isEmpty)
        .background(Color.ticlemoaBlack)
        .cornerRadius(6.0)
        .padding(.horizontal, 21)
        .ticlmoaAlert(
            isPresented: $isArticlesDeletingButtonTouched,
            title: "아티클 삭제",
            style: .confirm(message: "선택한 \(self.chekableArticles.filter{$0.isSelected}.count)개의 아티클을 삭제하시겠습니까?"),
            isConfirmAlert: true
        ) { _ in
            Task {
                let deletingArticles = self.chekableArticles
                    .filter { $0.isSelected }
                    .map { $0.article }
                do {
                    try await modelContainer.articleModel.remove(deletingArticles)
                    showToast = true
                    toastMessage = "삭제가 완료되었습니다."
                } catch {
                    print("식제 실패")
                    print(error.localizedDescription) // TODO: 실패 토스트 메세지 띄우기
                }
            }
            return (true, "")
        }
    }
}
