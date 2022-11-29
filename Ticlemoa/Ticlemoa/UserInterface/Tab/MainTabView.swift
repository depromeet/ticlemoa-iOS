//
//  MainTabView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .setupBackground()
                .tabItem {
                    Tab.home.imageItem
                    Tab.home.textItem
                }
            CommunityView()
                .setupBackground()
                .tabItem {
                    Tab.community.imageItem
                    Tab.community.textItem
                }
        }
        .overlay {
            VStack {
                Spacer()
                Image("add")
                Spacer()
                    .frame(height: 16)
            }
        }
    }
        
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
