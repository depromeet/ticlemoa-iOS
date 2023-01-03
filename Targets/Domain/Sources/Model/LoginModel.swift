//
//  LoginModel.swift
//  Domain
//
//  Created by 김용우 on 2023/01/03.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

import API
import DomainInterface

public final class LoginModel: LoginModelProtocol {
    
    public var accessTokenPublisher: Published<String?>.Publisher { $accessToken }
    
    @Published private var accessToken: String?
    private let api: APIDetails = TiclemoaAPI()
    
    public init() { }
    
}

extension LoginModel {
    
    public func requestKakaoLogin(_ accessToken: String) async -> Bool {
        guard let data = await api.kakaoLogin(by: .init(
                accessToken: accessToken,
                vendor: "kakao"
            )
        ) else {
            return false
        }
        guard let response = try? JSONDecoder().decode(KakaoLoginResponse.self, from: data) else {
            return false
        }
        self.accessToken = response.accessToken
        
        return true
    }
    
}
