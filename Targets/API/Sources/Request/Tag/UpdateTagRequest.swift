//
//  UpdateTagRequest.swift
//  DomainInterface
//
//  Created by Joseph Cha on 2023/01/07.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct UpdateTagRequest {
    
    let accessToken: String
    let tagId: Int
    let body: Body
    
    public init(accessToken: String, tagId: Int, body: Body) {
        self.accessToken = accessToken
        self.tagId = tagId
        self.body = body
    }
    
    public struct Body: Encodable {
        let tagName: String
        
        public init(tagName: String) {
            self.tagName = tagName
        }
    }
}

extension UpdateTagRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        
        var request = URLRequest(
            url: baseURL.appendingPathComponent("/tag").appendingPathComponent("\(tagId)"),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.patch.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(self.body)
        
        return request
    }
}
