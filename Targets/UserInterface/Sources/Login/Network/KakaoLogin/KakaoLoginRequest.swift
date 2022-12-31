//
//  KakaoLoginRequest.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/21.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

struct KakaoLoginRequest: Encodable {
    /// KakaoTalk SDK 에서 발급해주는 "oauthToken"
    let accessToken: String
    let vendor: String
}
