//
//  Router.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/18.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

enum Router {
    /// 카카오톡 로그인
    case kakaoLogin(body: KakaoLoginRequest)
    
    private static let baseURLString = "http://ticlemoa-env-1.eba-6qebrvxf.ap-northeast-2.elasticbeanstalk.com"
    
    private enum HTTPMethod {
        case get
        case post
        case put
        case delete
        
        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .delete: return "DELETE"
            }
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .kakaoLogin: return .post
        }
    }
    
    private var path: String {
        switch self {
        case .kakaoLogin:
            return "/auth/kakao/login"
        }
    }
    
    func request() throws -> URLRequest {
        let urlString = "\(Router.baseURLString)\(path)"
        
        guard let url = URL(string: urlString) else {
            throw ErrorType.parseUrlFail
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case .kakaoLogin(let body):
            let json: [String: Any] = [
                "accessToken": "\(body.accessToken)",
                "vendor": "\(body.vendor)"
            ]
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return request
        }
    }
}
