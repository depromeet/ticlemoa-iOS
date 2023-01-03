//
//  KakaoLoginRequest.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/21.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public struct KakaoLoginRequest: Encodable {
    /// KakaoTalk SDK 에서 발급해주는 "oauthToken"
    let accessToken: String
    let vendor: String
    
    public init(accessToken: String, vendor: String) {
        self.accessToken = accessToken
        self.vendor = vendor
    }
    
    func makeURLRequest(by baseURL: URL) -> URLRequest {
        var request = URLRequest(
            url: baseURL,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = [
            "accessToken": "\(accessToken)",
            "vendor": "\(vendor)"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return request
    }
    
}
