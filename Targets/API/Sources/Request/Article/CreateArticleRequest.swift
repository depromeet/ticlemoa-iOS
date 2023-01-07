//
//  CreateArticleRequest.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct CreateArticleRequest {
    
    let accessToken: String
    let body: Body
    
    public struct Body: Encodable {
        let content: String
        let userId: Int
        let title: String
        let url: String
        let isPublic: Bool
        let tagIds: [Int]
    }
    
    public init(accessToken: String, body: Body) {
        self.accessToken = accessToken
        self.body = body
    }
    
}

extension CreateArticleRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL.appendingPathComponent("/article"),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(self.body)
        
        return request
    }
    
}
