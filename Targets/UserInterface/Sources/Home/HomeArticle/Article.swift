//
//  Article.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import Collections

typealias ArticleGroup = OrderedDictionary<String, [Article]>

struct Article: Identifiable, Hashable {
    let id: Int
    let date: String
    let title: String
    let content: String
    
    var dateParsed: Date { date.dateParsed() }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
}

struct Category {
    let id: Int
    let name: String
    let mainCategoryID: Int?
}

/* Dummy Data */
extension Article {
    static let article01 = Article(id: 1, date: "02/16/2022", title: "링크01", content: "링크01 내용")
    static let article02 = Article(id: 2, date: "03/16/2022", title: "링크02", content: "링크02 내용")
    static let article03 = Article(id: 3, date: "04/16/2022", title: "링크03", content: "링크03 내용")
    static let article04 = Article(id: 4, date: "05/16/2022", title: "링크04", content: "링크04 내용")
    static let article05 = Article(id: 5, date: "06/16/2022", title: "링크05", content: "링크05 내용")
    static let article06 = Article(id: 6, date: "07/16/2022", title: "링크06", content: "링크06 내용")
    static let article07 = Article(id: 7, date: "08/16/2022", title: "링크07", content: "링크07 내용")
    static let article08 = Article(id: 8, date: "09/16/2022", title: "링크08", content: "링크08 내용")
    static let article09 = Article(id: 9, date: "10/16/2022", title: "링크09", content: "링크09 내용")
    static let article10 = Article(id: 10, date: "11/16/2022", title: "링크10", content: "링크10 내용")
    static let article11 = Article(id: 11, date: "12/16/2022", title: "링크11", content: "링크11 내용")
    static let article12 = Article(id: 12, date: "01/16/2023", title: "링크12", content: "링크12 내용")
    static let article13 = Article(id: 13, date: "02/16/2023", title: "링크13", content: "링크13 내용")
    static let article14 = Article(id: 14, date: "03/16/2023", title: "링크14", content: "링크14 내용")
    static let article15 = Article(id: 15, date: "04/16/2023", title: "링크15", content: "링크15 내용")
    
    static var allArticles: [Article] {
        [
            Article.article01,
            Article.article02,
            Article.article03,
            Article.article04,
            Article.article05,
            Article.article06,
            Article.article07,
            Article.article08,
            Article.article09,
            Article.article10,
            Article.article11,
            Article.article12,
            Article.article13,
            Article.article14,
            Article.article15
        ]
    }
}

extension Category {
    // 카테고리
    static let development = Category(id: 1, name: "개발", mainCategoryID: nil)
    static let idea = Category(id: 2, name: "아이디어", mainCategoryID: nil)
    
    // 하위 카테고리
    static let ios = Category(id: 101, name: "아이폰개발", mainCategoryID: 1)
    static let android = Category(id: 102, name: "안드로이드개발", mainCategoryID: 1)
    static let fun = Category(id: 201, name: "재미", mainCategoryID: 2)
    static let design = Category(id: 202, name: "디자인", mainCategoryID: 2)
}

extension Category {
    static let categories: [Category] = [
        .development,
        .idea
    ]
    
    static let subCategories: [Category] = [
        .ios,
        .android,
        .fun,
        .design
    ]
    
    static let all: [Category] = categories + subCategories
}

