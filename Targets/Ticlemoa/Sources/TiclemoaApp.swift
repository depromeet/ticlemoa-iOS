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

@main
struct TiclemoaApp: App {
    
    private let modelContainer = ModelContainer(
        articleModel: ArticleModel(),
        tagModel: TagModel()
    )
	
	var body: some Scene {
		WindowGroup {
            ContentView()
                .environmentObject(modelContainer)
		}
	}
}
