//
//  ReadArticleRequest.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct ReadArticleRequest {
    
    let accessToken: String
    let userId: Int
    let tagId: Int?
    
    public init(accessToken: String, userId: Int, tagId: Int? = nil) {
        self.accessToken = accessToken
        self.userId = userId
        self.tagId = tagId
    }
    
}

extension ReadArticleRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var urlComponents = URLComponents(
            url: baseURL.appendingPathComponent("/article").appendingPathComponent("/\(userId)"),
            resolvingAgainstBaseURL: false
        )
        if let tagId = tagId {
            urlComponents?.queryItems = [
                .init(name: "tagId", value: "\(tagId)")
            ]
        }
        var request = URLRequest(
            url: urlComponents?.url ?? baseURL,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}

