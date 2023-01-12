//
//  ArticleRow.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import DomainInterface

struct ArticleRow: View {
    @EnvironmentObject var modelContainer: ModelContainer
    @State private var tagNames: [String] = []
    @State private var isArticleSettingButtonTouched: Bool = false
    @State private var isArticleDeletingButtonTouched: Bool = false
    @State private var isAddingLinkViewPresented: Bool = false
    
    let article: Article
    
    var body: some View {
        HStack(spacing: 0) {
            Image("home_article_placeholder")
                .frame(width: 88, height: 88)
                .padding(.leading, 20)
                .padding(.trailing, 12)
                .cornerRadius(4)
            VStack(spacing: 12) {
                HStack(spacing: 0) {
                    Text(article.title)
                        .frame(height: 48)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .customFont(weight: 600, size: 16, lineHeight: 24)
                    Spacer()
                    Button {
                        HapticManager.instance.impact(style: .light)
                        isArticleSettingButtonTouched = true
                    } label: {
                        Image("article_setting_icon")
                            .frame(width: 20, height: 40) // 원래 3인데 잘 안눌려 10
                    }
                    .padding(.leading, 26)
                }
                HStack(spacing: 8) {
                    if tagNames.isEmpty {
                        Text("태그 없음")
                            .customFont(weight: 400, size: 12, lineHeight: 18)
                            .foregroundColor(Color.grey4)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.grey2)
                            .cornerRadius(4)
                    } else {
                        ForEach(tagNames, id: \.self) { tagName in
                            Text(tagName)
                                .customFont(weight: 400, size: 12, lineHeight: 18)
                                .foregroundColor(Color.grey4)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.grey2)
                                .cornerRadius(4)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.trailing, 25)
        }
        .frame(height: 112)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.grey1)
        .background(Color.grey1)
        .onReceive(self.modelContainer.tagModel.itemsPublisher) { tags in
            self.tagNames = tags
                .filter{article.tagIds.contains($0.id)}
                .map{$0.tagName}
        }
        .ticlemoaBottomSheet(
            isPresented: $isArticleSettingButtonTouched,
            content: {
                VStack(spacing: 8) {
                    ZStack {
                        Text(article.title)
                            .customFont(weight: 700, size: 18, lineHeight: 27)
                            .lineLimit(1)
                            .padding(.horizontal, 36)
                            .padding(.vertical, 16)
                    }
                    .frame(height: 59)
                    Button {
                        isAddingLinkViewPresented = true
                    } label: {
                        HStack(spacing: 0) {
                            Text("수정하기")
                                .customFont(weight: 600, size: 16, lineHeight: 24)
                                .foregroundColor(.ticlemoaBlack)
                                .padding(.leading, 36)
                            Spacer()
                            Image("right_vector")
                                .frame(width: 9.29, height: 15.8)
                                .padding(.trailing, 20.1)
                        }
                        .frame(height: 59)
                    }
                    .fullScreenCover(isPresented: $isAddingLinkViewPresented) {
                        AddingLinkView(modelContainer: modelContainer, fromWhere: .modifyingButton(article: article))
                    }

                    Button {
                        isArticleDeletingButtonTouched = true
                    } label: {
                        HStack(spacing: 0) {
                            Text("삭제하기")
                                .customFont(weight: 600, size: 16, lineHeight: 24)
                                .foregroundColor(.secondaryRed)
                                .padding(.leading, 36)
                            Spacer()
                        }
                        .frame(height: 59)
                    }
                }
                .padding(.bottom, 19)
            })
        .ticlmoaAlert(
            isPresented: $isArticleDeletingButtonTouched,
            title: "아티클 삭제",
            style: .confirm(message: "선택한 아티클을 삭제하시겠습니까?"),
            isConfirmAlert: true
        ) { _ in
            Task {
                do {
                    try await modelContainer.articleModel.remove([article])
                    isArticleSettingButtonTouched = false
                } catch {
                    print(error.localizedDescription)
                }
            }
            return (true, "")
        }
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: MockArticle())
    }
}
