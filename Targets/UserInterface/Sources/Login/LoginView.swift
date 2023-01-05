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
    @Binding var isLoggedIn: Bool
    @Environment(\.window) var window: UIWindow?
    @State var appleSignInDelegates: SignInWithAppleDelegates! = nil
    
    var body: some View {
        mainBody
            .onOpenURL { url in
                if viewModel.isKakaoTalkLogin(url) {
                    _ = viewModel.authControllerHandleOpen(url: url)
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
    
    var socialLoginButtons: some View {
        VStack {
            borderLineButton(
                "카카오톡으로 로그인",
                .yellow,
                action: {
                    HapticManager.instance.impact(style: .medium)
                    
                    Task {
                        let isSuccess = try await viewModel.kakaoButtonDidTap()
                        withAnimation { isLoggedIn = isSuccess }
                    }
                })
            .buttonStyle(ScaleButtonStyle())
//            borderLineButton(
//                "Apple으로 로그인",
//                .white,
//                action: {
//                    HapticManager.instance.impact(style: .medium)
//                    withAnimation { isLoggedIn = true }
//                })
            SignInWithApple()
              .frame(width: 280, height: 60)
              .onTapGesture(perform: showAppleLogin)
            
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(.horizontal, 20)
    }
        
    
    private func showAppleLogin() {
      let request = ASAuthorizationAppleIDProvider().createRequest()
      request.requestedScopes = [.fullName, .email]

      performSignIn(using: [request])
    }
    
    private func performSignIn(using requests: [ASAuthorizationRequest]) {
      appleSignInDelegates = SignInWithAppleDelegates(window: window) { success in
        if success {
          // update UI
        } else {
          // show the user an error
        }
      }

      let controller = ASAuthorizationController(authorizationRequests: requests)
      controller.delegate = appleSignInDelegates
      controller.presentationContextProvider = appleSignInDelegates

      controller.performRequests()
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
                        .customFont(
                            weight: 600,
                            size: 15,
                            lineHeight: 24,
                            style: .semiBold
                        )
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

//#if DEBUG
//import Domain
//
//struct LoginView_Previews: PreviewProvider {
//    static var modelContainer = ModelContainer(
//        articleModel: ArticleModel(),
//        tagModel: TagModel(),
//        loginModel: LoginModel()
//    )
//    @State static  var isLoggedIn: Bool = false
//
//    static var previews: some View {
//        LoginView(
//            viewModel:
//                LoginViewModel(
//                modelContainer: modelContainer
//                ),
//            isLoggedIn: $isLoggedIn
//        )
//    }
//}
//
//#endif
