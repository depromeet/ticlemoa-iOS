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
        .init(nickName: userData.nickName, accessToken: self.accessToken, userId: self.userId)
    }
}

public final class LoginModel: LoginModelProtocol {
    
    public var userDataPublisher: Published<LoginUser>.Publisher { $userData }
    
    @Published private var userData: LoginUser
    private let api: APIDetails = TiclemoaAPI()
    
    public init() {
        self.userData = LoginUserData(nickName: "", accessToken: nil, userId: nil) // 초기값 추가 UserDefault?
    }
    
}

extension LoginModel {
    
    public func isKakaoTalkLoginUrl(_ url: URL) -> Bool {
        AuthApi.isKakaoTalkLoginUrl(url)
    }
    
    public func authController(url: URL) -> Bool {
        AuthController.handleOpenUrl(url: url)
    }
    
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
    public func update(_ item: Article) async {
        let loginUser = LoginUserData(nickName: "테스트", accessToken: "토큰", userId: 0) // TODO: 전달방법 고민 필요 UserDefault?
        let uploadArticleRequest = item.uploadArticleRequest(with: loginUser)
        let result = await api.request(by: uploadArticleRequest)
        
        do {
            switch result {
                case .success(let data):
                    let response = try JSONDecoder().decode(UpdateArticleResponse.self, from: data)
                case .failure(let error):
                    print(error.description)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func requestKakaoLogin(_ accessToken: String) async -> Bool {
        let kakaoLoginRequest = KakaoLoginRequest(accessToken: accessToken)
        let result = await api.request(by: kakaoLoginRequest)
        
        do {
            switch result {
                case .success(let data):
                    let response = try JSONDecoder().decode(KakaoLoginResponse.self, from: data)
                    self.userData = response.updateAccessToken(from: userData)
                    return true
                case .failure(let error):
                    print(error.description)
                    return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
