//
//  OnboardingPageView.swift
//  UserInterface
//
//  Created by 김우성 on 2023/01/07.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .customFont(
                    weight: 600,
                    size: 24,
                    lineHeight: 36,
                    style: .semiBold
                )
                .multilineTextAlignment(.center)
            Image(imageName)
                .padding(.top, 50)
                .frame(maxHeight: 216.33)
                
        }.setupBackground()
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(
            imageName: "firstOnboardingImage",
            title: "아티클을 모아\n지식을 태산처럼 만들어봐요!")
    }
}
