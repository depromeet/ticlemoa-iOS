//
//  ReadTagRequest.swift
//  API
//
//  Created by Joseph Cha on 2023/01/07.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct ReadTagRequest {
    
    let accessToken: String
    let page: Int
    let take: Int
    
    public init(accessToken: String, page: Int, take: Int) {
        self.accessToken = accessToken
        self.page = page
        self.take = take
    }
}

extension ReadTagRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL.appendingPathComponent("/tag").appendingPathComponent("/\(page)")
                .appendingPathComponent("/\(take)"),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
