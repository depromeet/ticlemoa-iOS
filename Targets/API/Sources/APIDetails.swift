//
//  APIDetails.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public protocol APIDetails {

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
    
}
