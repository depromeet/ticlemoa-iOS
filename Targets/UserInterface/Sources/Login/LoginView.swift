//
//  LoginView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/12.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.window) var window: UIWindow?
    @State var appleSignInDelegates: SignInWithAppleDelegates! = nil
    
    @State var selectedPage: Int = 1
    var pages: Int = 3
    
    var body: some View {
        mainBody
            .background(Color.grey1)
//            .onOpenURL { url in
//                if viewModel.isKakaoTalkLogin(url) {
//                    _ = viewModel.authControllerHandleOpen(url: url)
//                }
//            }
    }
    
    var mainBody: some View {
        VStack {
            Spacer()
                .frame(maxHeight: 61)
            
            OnboardingTabView(selectedPage: $selectedPage, pages: pages)
            
            PageControl(
                selectedPage: $selectedPage,
                pages: pages,
                circleDiameter: 8.0,
                circleMargin: 8.0
            )
            .padding(.bottom, 100)
            Spacer()
            // 소셜 로그인 구현 시, 사용 예정
//            socialLoginButtons
//                .padding(.top, 60)
//            Button("임시 로그인 버튼") {
//                isLoggedIn = true
//            }
            RoundedButton(
                "시작하기",
                foregroundColor: Color.white,
                Color.ticlemoaBlack,
                imageName: "", action: {
                    Task {
                        HapticManager.instance.impact(style: .light)
                        let isSuccess = await viewModel.getAccessToken()
                        
                    }
                }
            )
            
            Spacer()
                .frame(maxHeight: 58)
            
        }
    }
}


// MARK: - UI Components
private extension LoginView {
    var headerTitles: some View {
        Group {
            Text("반갑습니다!\n티클모아에서 모아봐요")
                .customFont(
                    weight: 700,
                    size: 24,
                    lineHeight: 28.8,
                    style: .bold
                )
            
            Text("티클모아에서는 나의 아티클을 모으고,\n 다른 사람의 아티클도 모아볼 수 있어요 📝")
                .customFont(
                    weight: 500,
                    size: 14,
                    lineHeight: 21,
                    style: .medium
                )
        }
        .multilineTextAlignment(.center)
    }
    
    var ticlemoaIcon: some View {
        Color.grey2
            .frame(maxWidth: 214, maxHeight: 214)
            .cornerRadius(9.73)
            .overlay(
                Image("t_icon")
            )
    }
    
//    var socialLoginButtons: some View {
//        VStack(spacing: 12) {
//            RoundedButton(
//                "카카오톡으로 로그인",
//                Color.kakaoYellow,
//                imageName: "kakao_icon",
//                action: {
//                    HapticManager.instance.impact(style: .medium)
//                    
//                    Task {
//                        let isSuccess = try await viewModel.kakaoButtonDidTap()
//                        withAnimation { isLoggedIn = isSuccess }
//                    }
//                })
//            .buttonStyle(ScaleButtonStyle())
//            RoundedButton(
//                "Apple으로 로그인",
//                foregroundColor: .white,
//                Color.ticlemoaBlack,
//                imageName: "apple_icon_white",
//                action: {
//                    HapticManager.instance.impact(style: .medium)
//                    showAppleLogin()
//                })
//            //            SignInWithApple()
//            .onTapGesture(perform: showAppleLogin)
//            
//            .buttonStyle(ScaleButtonStyle())
//        }
//        .padding(.horizontal, 20)
//    }
    
    
    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        performSignIn(using: [request])
    }
    
    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        appleSignInDelegates = SignInWithAppleDelegates(window: window) { success in
            if success {
                // update UI
//                withAnimation { isLoggedIn = true }
            } else {
                // show the user an error
            }
        }
        
        let controller = ASAuthorizationController(authorizationRequests: requests)
        controller.delegate = appleSignInDelegates
        controller.presentationContextProvider = appleSignInDelegates
        
        controller.performRequests()
    }
    
    func RoundedButton(
        _ text: String,
        foregroundColor: Color = Color.darkRed,
        _ backgorund: Color,
        imageName: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                Rectangle()
                    .fill(backgorund)
                    .frame(maxHeight: 56)
//                    .cornerRadius(4)
                HStack {
                    Image(imageName)
                        .padding(.leading, 21)
                    Spacer()
                }.overlay(
                    Text(text)
                        .customFont(
                            weight: 600,
                            size: 15,
                            lineHeight: 24,
                            style: .semiBold
                        )
                        .foregroundColor(foregroundColor))
            }
            .cornerRadius(6)
            .padding(.horizontal, 20)
        }).padding(.top, 20)
        
    }
}

#if DEBUG

//struct LoginView_Previews: PreviewProvider {
//    static var modelContainer = ModelContainer(
//        articleModel: MockArticleModel(),
//        tagModel: MockTagModel(),
//        loginModel: MockLoginModel()
//    )
//    @State static  var isLoggedIn: Bool = false
//    
//    static var previews: some View {
//        LoginView(
//            viewModel:
//                LoginViewModel(
//                    modelContainer: modelContainer
//                ),
//            isLoggedIn: $isLoggedIn
//        )
//    }
//}

#endif
