//
//  TiclemoaApp.swift
//  Ticlemoa
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import Domain
import UserInterface

@main
struct TiclemoaApp: App {
    
    private let articleModel = ArticleModel()
    private let tagModel = TagModel()
	
	var body: some Scene {
		WindowGroup {
            ContentView()
                .environmentObject(articleModel)
                .environmentObject(tagModel)
		}
	}
}
