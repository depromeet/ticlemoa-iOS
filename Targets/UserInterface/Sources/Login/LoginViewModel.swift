//
//  LoginViewModel.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/18.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon


class LoginViewModel: ObservableObject {
    let network = LoginAPI()
    
    public func kakaoButtonDidTap() async throws -> Bool {
        var kakaoLoginerror: Error?
        let kakaoToken = await withCheckedContinuation { continuation in
            // 앱 로그인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    kakaoLoginerror = error
                    continuation.resume(returning: oauthToken)
                }
                
                // 웹 로그인
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    kakaoLoginerror = error
                    continuation.resume(returning: oauthToken)
                }
            }
        }
        
        guard kakaoLoginerror != nil else { return false }
        guard let token = kakaoToken?.accessToken else { return false }
        let body = KakaoLoginRequest(accessToken: token, vendor: "kakao")
        let repsonse = try await network.kakaoLogin(body: body)
        return (repsonse != nil)
    }
}




