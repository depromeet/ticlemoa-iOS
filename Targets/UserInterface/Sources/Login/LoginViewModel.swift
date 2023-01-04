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
    
    @EnvironmentObject var modelContainer: ModelContainer
    
    public func kakaoButtonDidTap() async throws -> Bool {
        await modelContainer.loginModel.checkKakaoLogin()
    }
    
}




