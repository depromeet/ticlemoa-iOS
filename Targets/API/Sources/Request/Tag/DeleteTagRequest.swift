//
//  DeleteTagRequest.swift
//  API
//
//  Created by Joseph Cha on 2023/01/07.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct DeleteTagRequest: Encodable {
    
    let accessToken: String
    let tagId: Int
    
    public init(accessToken: String, tagId: Int) {
        self.accessToken = accessToken
        self.tagId = tagId
    }
}

extension DeleteTagRequest: URLRequestMakable {
    
    public func makeURLRequest(by baseURL: URL) -> URLRequest {
        let urlComponents = URLComponents(
            url: baseURL.appendingPathExtension("/tag/\(tagId)"),
            resolvingAgainstBaseURL: false
        )
        
        var request = URLRequest(
            url: urlComponents?.url ?? baseURL,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.delete.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}

