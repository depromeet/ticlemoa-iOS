//
//  ContentView.swift
//  UserInterface
//
//  Created by Yongwoo Marco on 2022/11/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

public struct ContentView: View {
    @State private  var isLoggedIn: Bool = false
    
	public init() { }
	
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
