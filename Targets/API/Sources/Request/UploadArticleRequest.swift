//
//  UploadArticleRequest.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/22.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public struct UploadArticleRequest: Encodable {
    
    let accessToken: String
    
    let content: String
    let userId: Int = 0 // TODO: 서버 개발 되면, 이부분 변경필요 12.22
    let title: String
    let url: String
    let isPublic: Bool
    let tagIds: [Int]
    
    public init(
        accessToken: String,
        content: String,
        title: String,
        url: String,
        isPublic: Bool,
        tagIds: [Int])
    {
        self.accessToken = accessToken
        self.content = content
        self.title = title
        self.url = url
        self.isPublic = isPublic
        self.tagIds = tagIds
    }
    
    func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = [
            "content"   : content,
            "userId"    : userId,
            "title"     : title,
            "url"       : url,
            "isPublic"  : isPublic,
            "tagIds"    : tagIds,
        ]
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return request
    }
    
}
