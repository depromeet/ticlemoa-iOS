//
//  TiclemoaApp.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Domain
import UserInterface

import SwiftUI

import KakaoSDKCommon

@main
struct TiclemoaApp: App {
    
    @StateObject var modelContainer = ModelContainer(
        articleModel: ArticleModel(),
        tagModel: TagModel(),
        loginModel: LoginModel()
    )
    
    init() {
        KakaoSDK.initSDK(appKey: Keys.kakaoappkey)
    }
	
	var body: some Scene {
		WindowGroup {
            ContentView(modelContainer)
                .environmentObject(modelContainer)
                .preferredColorScheme(.light)
		}
	}
}
