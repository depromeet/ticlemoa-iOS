//
//  Article.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import Collections
import SwiftUI
import DomainInterface

typealias ArticleGroup = OrderedDictionary<String, [GroupedArticle]>

struct GroupedArticle: Identifiable, Hashable {
    let id: Int
    let date: String = "01/14/2023"
    let title: String
    let content: String
    let urlString: String
    
    var dateParsed: Date {
        return date.dateParsed()
    }
    
    var month: String {
        let year = dateParsed.formatted(.dateTime.year())
        let month = dateParsed.formatted(.dateTime.month(.twoDigits))
        return year + "." + month
    }
    
    // TODO: 2. 이미지 추출해서 이미지 URL 혹은 Image 전달
    var imageURLString: String {
        guard let url = URL(string: urlString) else { return "" }
        Task {
            if let imageURLString = try await findThumnail(url: url) {
                if let resultString = stringParsing(text: imageURLString) {
                    return resultString.1
                }
                
            }
            return ""
        }
        return ""
    }
    
    func stringParsing(text:String) -> (String,String,String)? {
        let index0 = text.startIndex
        let indexE = text.endIndex
        let result = text[index0 ..< indexE]
        
        guard text.contains("http") else { return nil }
        
        if let range0 = text.range(of: "content=") {
            let startWord = text.index(text[range0].endIndex, offsetBy: 1)
            let endWord = text.endIndex
            let w0 = text[text.startIndex ..< startWord]
            let w1 = text[startWord ..< text.index(text.endIndex, offsetBy: -3)]
            let w2 = text[endWord ..< text.endIndex]
            
            return (String(w0),String(w1),String(w2))
        } else {
         return nil
        }
    }
    
    // TODO: 1. 썸네일 추출 하는 방법 조사 필요
    func findThumnail(url: URL) async throws ->  String? {
        for try await line in url.lines {
            if line.contains("og:image") {
                return line.trimmingCharacters(in: .whitespaces)
            }
        }
        return nil
    }
}

/* Dummy Data */
extension GroupedArticle {
    static let article01 = GroupedArticle(id: 1, title: "우육면관", content: "링크01 내용", urlString: "https://m.blog.naver.com/hjy6005/222428005687")
    static let article02 = GroupedArticle(id: 2, title: "홍대삭", content: "링크02 내용", urlString: "https://zazak.tistory.com/3035")
    static let article03 = GroupedArticle(id: 3, title: "자가제면홍제우동", content: "링크03 내용", urlString: "https://m.blog.naver.com/ye_onny/222671614005")
    static let article04 = GroupedArticle(id: 4, title: "우동가조쿠", content: "링크04 내용", urlString: "https://m.blog.naver.com/ock9ock9/221319743409")
    static let article05 = GroupedArticle(id: 5, title: "시장맥주", content: "링크05 내용", urlString: "https://m.blog.naver.com/yuuun__is/221381716835")
    static let article06 = GroupedArticle(id: 6, title: "버거인뉴욕", content: "링크06 내용", urlString: "https://m.blog.naver.com/ekwjd3011/221482432534")
    static let article07 = GroupedArticle(id: 7, title: "동화가든", content: "링크07 내용", urlString: "https://blog.naver.com/PostView.naver?blogId=inileunji&logNo=222382494928&redirect=Dlog&widgetTypeCall=true&topReferer=https%3A%2F%2Fwww.google.com%2F&directAccess=false")
    static let article08 = GroupedArticle(id: 8, title: "사대부집 곳간", content: "링크08 내용", urlString: "https://m.blog.naver.com/reve8612/222860100908")
    static let article09 = GroupedArticle(id: 9, title: "창고43", content: "링크09 내용", urlString: "https://pinksoap.tistory.com/507")
    static let article10 = GroupedArticle(id: 10, title: "연어롭다", content: "링크10 내용", urlString: "https://m.blog.naver.com/icecream0514/222694311739")
    static let article11 = GroupedArticle(id: 11, title: "라이카 시네마", content: "링크11 내용", urlString: "http://laikacinema.com/about")
    static let article12 = GroupedArticle(id: 12, title: "히츠지야", content: "링크12 내용",urlString: "https://m.blog.naver.com/shinemrk/221646591105")
    static let article13 = GroupedArticle(id: 13, title: "신촌 여수집", content: "링크13 내용", urlString: "https://m.blog.naver.com/sielle83/221491184817")
    static let article14 = GroupedArticle(id: 14, title: "애플", content: "링크14 내용",urlString: "https://www.apple.com")
    static let article15 = GroupedArticle(id: 15, title: "디자이너와 프로그래머가 만났을 때", content: "링크15 내용", urlString: "https://www.depromeet.com")
    static let article16 = GroupedArticle(id: 16, title: "F-rame 편집샵", content: "링크15 내용", urlString: "https://f-rame.com")
    
    static var allArticles: [GroupedArticle] {
        [
            GroupedArticle.article01,
            GroupedArticle.article02,
            GroupedArticle.article03,
            GroupedArticle.article04,
            GroupedArticle.article05,
            GroupedArticle.article06,
            GroupedArticle.article07,
            GroupedArticle.article08,
            GroupedArticle.article09,
            GroupedArticle.article10,
            GroupedArticle.article11,
            GroupedArticle.article12,
            GroupedArticle.article13,
            GroupedArticle.article14,
            GroupedArticle.article15,
            GroupedArticle.article16
        ]
    }
}
