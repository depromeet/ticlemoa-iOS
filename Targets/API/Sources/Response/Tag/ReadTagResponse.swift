//
//  ReadTagResponse.swift
//  API
//
//  Created by Joseph Cha on 2023/01/07.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct ReadTagResponse: Decodable {
    public let tags: [ReadTag]
    
    public struct ReadTag: Decodable {
        public let id: Int
        public let userId: Int
        public let tagName: String
    }
}
