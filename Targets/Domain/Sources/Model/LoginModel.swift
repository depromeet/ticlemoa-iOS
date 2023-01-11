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
//import KakaoSDKUser
//import KakaoSDKAuth
//import KakaoSDKCommon


extension KakaoLoginResponse {
    func updateLoginUser() -> LoginUserData? {
        guard let baseData = LoginUserData.shared else {
            return nil
        }
        LoginUserData.shared = .init(
            nickName: baseData.nickName,
            accessToken: self.accessToken,
            userId: self.userId,
            mail: baseData.mail
        )
        return LoginUserData.shared
    }
}

public final class LoginModel: LoginModelProtocol {
    
    public var userDataPublisher: Published<LoginUser?>.Publisher { $userData }
    
    @Published private var userData: LoginUser?
    private let api: APIDetails = TiclemoaAPI()
    
    public init() {
        userData = LoginUserData.shared
    }
}

// MARK: - Kakao
extension LoginModel {
    
//    public func isKakaoTalkLoginUrl(_ url: URL) -> Bool {
//        AuthApi.isKakaoTalkLoginUrl(url)
//    }
//
//    public func authController(url: URL) -> Bool {
//        AuthController.handleOpenUrl(url: url)
//    }
//
//    public func checkKakaoLogin() async -> Bool {
//        switch await kakaoAccessToken() {
//        case .success(let token):
//            return await requestKakaoLogin(token.accessToken)
//        case .failure(let error):
//            print(error.localizedDescription)
//            return false
//        }
//    }
//
//    private func kakaoAccessToken() async -> Result<OAuthToken, Error> {
//        await withCheckedContinuation { continuation in
//            // 앱 로그인
//            if (UserApi.isKakaoTalkLoginAvailable()) {
//                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                    guard let token = oauthToken else {
//                        continuation.resume(returning: .failure(error!))
//                        return
//                    }
//                    continuation.resume(returning: .success(token))
//                }
//
//                // 웹 로그인
//            } else {
//                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//                    guard let token = oauthToken else {
//                        continuation.resume(returning: .failure(error!))
//                        return
//                    }
//                    continuation.resume(returning: .success(token))
//                }
//            }
//        }
//    }
//
//    private func requestKakaoLogin(_ accessToken: String) async -> Bool {
//        let kakaoLoginRequest = KakaoLoginRequest(accessToken: accessToken)
//        let result = await api.request(by: kakaoLoginRequest)
//
//        do {
//            switch result {
//            case .success(let data):
//                let response = try JSONDecoder().decode(KakaoLoginResponse.self, from: data)
//                self.userData = response.updateLoginUser()
//                return true
//            case .failure(let error):
//                print(error.description)
//                return false
//            }
//        } catch {
//            print(error.localizedDescription)
//            return false
//        }
//    }
    
}


extension LoginModel {
    
    // 최초 접속 1 회만, 호출됩니다.
    public func requestAccessToken() async -> Bool {
        let request = UserTokenRequest()
        let result = await api.request(by: request)
        
        do {
            switch result {
            case .success(let data):
                let response = try JSONDecoder().decode(UserTokenRespons.self, from: data)
                let accessToken = response.accessToken
                let userId = response.userId
                
                let userData = LoginUserData.init(
                    nickName: "태산이",
                    accessToken: accessToken,
                    userId: userId,
                    mail: ""
                )
                self.userData = userData
                LoginUserData.shared = userData
                
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
    
    public func nicknameChangeTo(_ nickname: String) {
        guard let oldValue = userData else { return } // TODO: 에러처리 필요
        let newValue = LoginUserData(
            nickName: nickname,
            accessToken: oldValue.accessToken,
            userId: oldValue.userId,
            mail: oldValue.mail
        )
        userData = newValue
        LoginUserData.shared = newValue
    }
    
    public func deleteAccount() async -> Bool {
        guard let accessToken = userData?.accessToken else { return false }
        userData = nil
        let accountDeletionRequest = AccountDeletionRequest(accessToken: accessToken)
        let result = await api.request(by: accountDeletionRequest)
        switch result {
        case .success: return true
        case .failure: return false
        }
    }

}
