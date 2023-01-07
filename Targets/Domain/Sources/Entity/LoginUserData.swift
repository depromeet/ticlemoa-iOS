//
//  LoginUserData.swift
//  Domain
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import DomainInterface

import Foundation

struct LoginUserData: LoginUser {
    let nickName: String
    let accessToken: String?
    let userId: Int?
}
