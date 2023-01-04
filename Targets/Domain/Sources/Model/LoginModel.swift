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

import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

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
    
    public func checkKakaoLogin() async -> Bool {
        switch await kakaoAccessToken() {
            case .success(let token):
                return await requestKakaoLogin(token.accessToken)
            case .failure(let error):
                print(error.localizedDescription)
                return false
        }
    }
    
    private func kakaoAccessToken() async -> Result<OAuthToken, Error> {
        await withCheckedContinuation { continuation in
            // 앱 로그인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    guard let token = oauthToken else {
                        continuation.resume(returning: .failure(error!))
                        return
                    }
                    continuation.resume(returning: .success(token))
                }
                
            // 웹 로그인
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    guard let token = oauthToken else {
                        continuation.resume(returning: .failure(error!))
                        return
                    }
                    continuation.resume(returning: .success(token))
                }
            }
        }
    }
        self.userData = response.updateAccessToken(from: userData)
        
        return true
    }
    
}
