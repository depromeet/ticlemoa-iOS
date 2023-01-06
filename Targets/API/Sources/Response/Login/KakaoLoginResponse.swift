//
//  KakaoLoginResponse.swift
//  API
//
//  Created by 김우성 on 2022/12/21.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public struct KakaoLoginResponse: Decodable {
    let accessToken: String
    let userId: Int
    
    init(accessToken: String, userId: Int) {
        self.accessToken = accessToken
        self.userId = userId
    }
    
}
