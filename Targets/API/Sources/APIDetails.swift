//
//  APIDetails.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public protocol APIDetails {
    func request(by request: URLRequestMakable) async -> Result<Data, NetworkError>
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
            fatalError(NetworkError.inValidURLString.description)
        }
        self.baseURL = baseURL
    }
    
}

extension TiclemoaAPI: APIDetails {
    
    public func request(by request: URLRequestMakable) async -> Result<Data, NetworkError> {
        let urlRequest = request.makeURLRequest(by: baseURL)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return .failure(.validationError)
            }
            switch statusCode {
                case 200, 201:      return .success(data)
                case 400..<500:     return .failure(.validationError)
                case 500..<600:     return .failure(.serverError)
                default:
                    return .failure(.unknownError)
            }
        } catch {
            return .failure(.notFound)
        }
    }
    
}
