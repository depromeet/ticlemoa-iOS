//
//  APIDetails.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public protocol APIDetails {
    func kakaoLogin(by request: KakaoLoginRequest) async -> Data?
    func uploadArticle(by request: UploadArticleRequest) async -> Data?
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

// MARK: Login
extension TiclemoaAPI: APIDetails {
    
    public func kakaoLogin(by request: KakaoLoginRequest) async -> Data? {
        let urlRequest = request.makeURLRequest(by: baseURL)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let httpResponse = response as? HTTPURLResponse
            print("DEBUG: ", httpResponse!)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 201 else {
                return nil
            }
            print("DEUBG: \(response.description)")
            return data
        } catch {
            return nil
        }
    }
    
}

// MARK: Article
extension TiclemoaAPI {
    
    public func uploadArticle(by request: UploadArticleRequest) async -> Data? {
        let urlRequest = request.makeURLRequest(by: baseURL)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let httpResponse = response as? HTTPURLResponse
            print("DEBUG: ", httpResponse!)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 201 else {
                return nil
            }
            print("DEUBG: \(response.description)")
            return data
        } catch {
            return nil
        }
    }
    
}
