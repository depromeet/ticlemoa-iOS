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

extension KakaoLoginResponse {
    func updateAccessToken(from userData: LoginUser) -> LoginUserData {
        .init(nickName: userData.nickName, accessToken: self.accessToken)
    }
}

public final class LoginModel: LoginModelProtocol {
    
    public var userDataPublisher: Published<LoginUser>.Publisher { $userData }
    
    @Published private var userData: LoginUser
    private let api: APIDetails = TiclemoaAPI()
    
    public init() {
        self.userData = LoginUserData(nickName: "", accessToken: nil) // 초기값 추가 UserDefault?
    }
    
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
        self.userData = response.updateAccessToken(from: userData)
        
        return true
    }
    
}
