//
//  CreateTagRequest.swift
//  API
//
//  Created by Joseph Cha on 2023/01/07.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct CreateTagRequest {
    
    let accessToken: String
    let body: Body
    
    public struct Body: Encodable {
        let tagName: String
        
        public init(tagName: String) {
            self.tagName = tagName
        }
    }
    
    public init(accessToken: String, body: Body) {
        self.accessToken = accessToken
        self.body = body
    }
}

extension CreateTagRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL.appendingPathComponent("/tag"),
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
