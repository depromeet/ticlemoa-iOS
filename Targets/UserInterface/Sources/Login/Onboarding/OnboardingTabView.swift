//
//  OnboardingTabView.swift
//  UserInterface
//
//  Created by 김우성 on 2023/01/07.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

struct OnboardingTabView: View {
    
    @Binding var selectedPage: Int
    var pages: Int
    
    var body: some View {
        VStack {
            TabView(selection: $selectedPage) {
                OnboardingPageView(
                    imageName: "firstOnboardingImage",
                    title: "아티클을 모아\n지식을 태산처럼 만들어봐요!"
                )
                .tag(1)
                
                OnboardingPageView(
                    imageName: "secondOnboardingImage",
                    title: "아티클 링크를\n쉽게 저장하고, 관리해요"
                )
                .tag(2)
                
                OnboardingPageView(
                    imageName: "thirdOnboardingImage",
                    title: "같은 관심사를 가진 사람들과\n저장한 아티클을 나눠요"
                )
                .tag(3)
                
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.width < 0 {
                        // left
                        guard selectedPage < pages else { return }
                        selectedPage += 1
                    }
                    
                    if value.translation.width > 0 {
                        // right
                        guard selectedPage > 1 else { return }
                        selectedPage -= 1
                    }
                    
                })
            )
        }
        
        
        
    }
}
