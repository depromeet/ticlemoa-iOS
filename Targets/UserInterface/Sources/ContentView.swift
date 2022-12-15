//
//  ContentView.swift
//  UserInterface
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon

public struct ContentView: View {
    @State private  var isLoggedIn: Bool = false
    
    public init() {
        let appKey = "a864acaf7534a2c1a627e21d352d2e49"
        KakaoSDK.initSDK(appKey: appKey)
        
    }
    
    public var body: some View {
        Group {
            if isLoggedIn {
                MainTabView()
                    .transition(.scale)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .transition(.scale)
                
            }
        }
    }
    
}
