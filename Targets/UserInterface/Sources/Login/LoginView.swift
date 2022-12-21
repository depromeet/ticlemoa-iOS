//
//  LoginView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/12.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

struct LoginView: View {
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        mainBody
            .onOpenURL { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
            .setupBackground()
    }
    
    var mainBody: some View {
        VStack {
            Spacer()
                .frame(maxHeight: 61)
            headerTitles
            Spacer()
            Color.grey2
                .frame(maxWidth: 214, maxHeight: 214)
            
            Spacer()
            socialLoginButtons
            Spacer()
                .frame(maxHeight: 58)
        }
        .task {
            do {
                let response = try await LoginAPI().kakaoLogin()
                
                print("DEBUG: Response \(response!.accessToken)")
            } catch {
                print(error)
            }
            
        }
    }
}


// MARK: - UI Components
private extension LoginView {
    var headerTitles: some View {
        Group {
            Text("반갑습니다!\n티클모아에서 모아봐요")
                .pretendFont(.title3)
            
            Text("티클모아에서는 나의 아티클을 모으고,\n 다른 사람의 아티클도 모아볼 수 있어요 📝")
                .pretendFont(.body1)
        }
        .multilineTextAlignment(.center)
    }
    
    var socialLoginButtons: some View {
        VStack {
            borderLineButton(
                "카카오톡으로 로그인",
                .yellow,
                action: {
                    HapticManager.instance.impact(style: .medium)
                    
                    if (UserApi.isKakaoTalkLoginAvailable()) {
                        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                            print(oauthToken)
                            print(error)
                            withAnimation { isLoggedIn = true }
                        }
                    } else {
                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                            print(oauthToken)
                            print(error)
                            withAnimation { isLoggedIn = true }
                        }
                    }
                })
            .buttonStyle(ScaleButtonStyle())
            borderLineButton(
                "Apple으로 로그인",
                .white,
                action: {
                    HapticManager.instance.impact(style: .medium)
                    withAnimation { isLoggedIn = true }
                })
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(.horizontal, 20)
    }
    
    func borderLineButton(
        _ text: String,
        _ backgorund: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                Rectangle()
                    .fill(backgorund)
                    .frame(maxHeight: 56)
                    .cornerRadius(12)
                VStack {
                    Text(text)
                        .pretendFont(.subhead3)
                        .foregroundColor(.black)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 1.2)
            )
        })
        
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static  var isLoggedIn: Bool = false
    
    static var previews: some View {
        LoginView(isLoggedIn: $isLoggedIn)
    }
}
