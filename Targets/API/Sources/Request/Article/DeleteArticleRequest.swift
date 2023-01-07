//
//  DeleteArticleRequest.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct DeleteArticleRequest {
    
    let accessToken: String
    let articleIds: [String]
    
    public init(accessToken: String, articleIds: [String]) {
        self.accessToken = accessToken
        self.articleIds = articleIds
    }
    
}

extension DeleteArticleRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL.appendingPathComponent("/article").appendingPathComponent(articleIds.joined(separator: ",")),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.delete.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
}
