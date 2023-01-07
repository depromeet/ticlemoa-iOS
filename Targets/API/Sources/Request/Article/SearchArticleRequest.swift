//
//  FetchArticleRequest.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct SearchArticleRequest: Encodable {
    
    let accessToken: String
    let search: String
    
    public init(accessToken: String, search: String) {
        self.accessToken = accessToken
        self.search = search
    }
    
}

extension SearchArticleRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var urlComponents = URLComponents(
            url: baseURL.appendingPathComponent("/article"),
            resolvingAgainstBaseURL: false
        )
        urlComponents?.queryItems = [
            .init(name: "search", value: search)
        ]
        var request = URLRequest(
            url: urlComponents?.url ?? baseURL, // TODO: 에러처리 고민
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
}
