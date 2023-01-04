//
//  APIDetails.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public protocol APIDetails {
    func request(by request: URLRequestMakable) async throws -> Data
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public struct TiclemoaAPI {
    
    private let baseURL: URL
    
    public init() {
        guard let baseURL = URL(string: URLStrings.host) else {
            fatalError(NetworkError.inValidURLString.rawValue)
        }
        self.baseURL = baseURL
    }
    
}

extension TiclemoaAPI: APIDetails {
    
    public func request(by request: URLRequestMakable) async throws -> Data {
        let urlRequest = request.makeURLRequest(by: baseURL)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 || httpResponse.statusCode == 201
            else {
                throw NetworkError.inValidURLRequest
            }
            
            return data
        } catch {
            throw NetworkError.inValidURLRequest
        }
    }
    
}
