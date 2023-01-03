//
//  LoginViewModel.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/18.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import SwiftUI

import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon


class LoginViewModel: ObservableObject {
    
    @EnvironmentObject var modelContainer: ModelContainer
    
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
        
        guard kakaoLoginerror == nil else { return false }
        guard let accessToken = kakaoToken?.accessToken else { return false }
        
        return await modelContainer.loginModel.requestKakaoLogin(accessToken)
    }
}




