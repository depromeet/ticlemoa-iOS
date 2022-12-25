//
//  UserInfoService.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/22.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

class UserInfoService {
    static let shared = UserInfoService()
    private init() {}
    
    var accessToken: String?
    
}
