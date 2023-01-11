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

struct GroupedArticle: Identifiable {
    let id: Int
    let article: Article
    let date: String = "01/14/2023"
    
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
        guard let url = URL(string: article.imageUrl) else { return "" }
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
