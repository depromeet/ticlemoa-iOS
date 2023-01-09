//
//  GetUserTokenResponse.swift
//  API
//
//  Created by 김우성 on 2023/01/09.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct GetUserTokenResponse: Decodable {
    public let accessToken: String
    public let userId: Int
    
    init(accessToken: String, userId: Int) {
        self.accessToken = accessToken
        self.userId = userId
    }
}
