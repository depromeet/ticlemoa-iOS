//
//  NetworkRequest.swift
//  API
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public protocol NetworkRequestable {
    func request() async throws -> (Data, URLResponse)
}

public struct NetworkRequest {
    
    let urlRequest: URLRequest
    
    init?(bundle: TiclemoaURL) {
        guard let url = bundle.makeURL() else {
            return nil
        }
        self.urlRequest = URLRequest(url: url)
    }
    
    init(bundle: TiclemoaURLRequest) {
        self.urlRequest = bundle.makeURLRequest()
    }
    
}

extension NetworkRequest: NetworkRequestable {
    
    public func request() async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(for: urlRequest)
    }

}
