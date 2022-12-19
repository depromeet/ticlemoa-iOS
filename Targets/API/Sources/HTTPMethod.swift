//
//  TiclemoaRequest.swift
//  API
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

struct TiclemoaURL {
    let url: URL
    let path: String
    let queries: [String: String]
    
    func makeURL() -> URL? {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        urlComponents.queryItems = queries.map({ URLQueryItem(name: $0, value: $1) })
        return urlComponents.url
    }
    
}

struct TiclemoaURLRequest {
    let url: URL
    let httpMethod: HTTPMethod
    let bodyParam: [String: String]

    func makeURLRequest() -> URLRequest {
        return {
            var request = URLRequest(url: url)
            request.httpMethod = request.httpMethod
            // ..
            return request
        }()
    }
    
}
