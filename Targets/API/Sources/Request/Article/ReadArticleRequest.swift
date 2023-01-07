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
    
    public init(accessToken: String, userId: Int) {
        self.accessToken = accessToken
        self.userId = userId
    }
    
}

extension ReadArticleRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL.appendingPathComponent("/article").appendingPathComponent("/\(userId)"),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}

