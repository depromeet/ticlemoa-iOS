//
//  GetUserTokenRequest.swift
//  API
//
//  Created by 김우성 on 2023/01/09.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct UserTokenRequest {
    public init() {}
}

extension UserTokenRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL.appendingPathComponent("/auth/free"),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
