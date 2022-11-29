//
//  HomeArticleList.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

struct HomeArticleList: View {
    var body: some View {
        List {
            ArticleRow()
            ArticleRow()
            ArticleRow()
            ArticleRow()
            ArticleRow()
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity)
    }
}

struct HomeArticleList_Previews: PreviewProvider {
    static var previews: some View {
        HomeArticleList()
    }
}
