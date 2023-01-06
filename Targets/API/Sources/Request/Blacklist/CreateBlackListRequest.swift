//
//  CreateBlackListRequest.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct CreateBlackListRequest {
    
    let accessToken: String
    let body: Body
    
    public struct Body: Encodable {
        let targetId: Int
    }
    
    public init(accessToken: String, body: Body) {
        self.accessToken = accessToken
        self.body = body
    }
    
}

extension CreateBlackListRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL.appendingPathExtension("/blackList"),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(self.body)
        
        return request
    }
    
}

