//
//  AccountDeletionRequest.swift
//  API
//
//  Created by Shin Jae Ung on 2023/01/09.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct AccountDeletionRequest {
    let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}

extension AccountDeletionRequest: URLRequestMakable {
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL.appendingPathComponent("/auth/withdraw"),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(AccountDeletionBody(accessToken: accessToken))
        return request
    }
}

private struct AccountDeletionBody: Encodable {
    let accessToken: String
}
