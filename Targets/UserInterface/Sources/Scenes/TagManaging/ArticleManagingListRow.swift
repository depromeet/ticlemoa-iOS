//
//  ArticleManagingListRow.swift
//  UserInterface
//
//  Created by Joseph Cha on 2023/01/13.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

struct ArticleManagingListRow: View {
    @EnvironmentObject var modelContainer: ModelContainer
    @State private var tagNames: [String] = []
    @Binding var checkableArticle: CheckableArticle
    
    var body: some View {
        HStack(spacing: 0) {
            Image("home_article_placeholder")
                .frame(width: 88, height: 88)
                .padding(.leading, 20)
                .padding(.trailing, 12)
                .cornerRadius(4)
            VStack(spacing: 12) {
                HStack(spacing: 0) {
                    Text(checkableArticle.article.title)
                        .frame(height: 48)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .customFont(weight: 600, size: 16, lineHeight: 24)
                    Spacer()
                    Image(checkableArticle.isSelected ? "radio_on" : "radio_off")
                        .frame(width: 10, height: 7)
                    .padding(.leading, 22.7)
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
        .onTapGesture {
            self.checkableArticle.isSelected.toggle()
        }
        .onReceive(self.modelContainer.tagModel.itemsPublisher) { tags in
            self.tagNames = tags
                .filter{checkableArticle.article.tagIds.contains($0.id)}
                .map{$0.tagName}
        }
    }
}
