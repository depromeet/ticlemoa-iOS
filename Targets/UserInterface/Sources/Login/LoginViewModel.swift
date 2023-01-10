//
//  LoginViewModel.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/18.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @ObservedObject var modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    public func kakaoButtonDidTap() async throws -> Bool {
        await modelContainer.loginModel.checkKakaoLogin()
    }
    
}

// MARK: Auth
extension LoginViewModel {
    
    func getAccessToken() async -> Bool {
        await modelContainer.loginModel.requestAccessToken()
    }
    
    func isKakaoTalkLogin(_ url: URL) -> Bool {
        modelContainer.loginModel.isKakaoTalkLoginUrl(url)
    }
    
    func authControllerHandleOpen(url: URL) -> Bool {
        modelContainer.loginModel.authController(url: url)
    }
    
}



