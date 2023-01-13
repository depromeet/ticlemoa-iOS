//
//  ToastMessage.swift
//  UserInterface
//
//  Created by Joseph Cha on 2023/01/14.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

struct Toast: ViewModifier {
    static let short: TimeInterval = 2
    static let long: TimeInterval = 3.5
    
    let message: String
    @Binding var isShowing: Bool
    let config: Config
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack(spacing: 0) {
            if isShowing {
                Group {
                    Text(message)
                        .customFont(weight: 600, size: 14, lineHeight: 21)
                        .multilineTextAlignment(.center)
                        .foregroundColor(config.textColor)
                }
                .frame(width: 303, height: 44)
                .background(config.backgroundColor)
                .cornerRadius(4)
                .onTapGesture {
                    isShowing = false
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                    }
                }
            }
            Spacer()
        }
        .animation(config.animation, value: isShowing)
        .transition(config.transition)
    }
    
    struct Config {
        let textColor: Color
        let font: Font
        let backgroundColor: Color
        let duration: TimeInterval
        let transition: AnyTransition
        let animation: Animation
        
        init(textColor: Color = .white,
             font: Font = .system(size: 14),
             backgroundColor: Color = .grey4,
             duration: TimeInterval = Toast.short,
             transition: AnyTransition = .opacity,
             animation: Animation = .linear(duration: 0.3)) {
            self.textColor = textColor
            self.font = font
            self.backgroundColor = backgroundColor
            self.duration = duration
            self.transition = transition
            self.animation = animation
        }
    }
}

extension View {
    func toast(message: String,
               isShowing: Binding<Bool>,
               config: Toast.Config) -> some View {
        self.modifier(Toast(message: message,
                            isShowing: isShowing,
                            config: config))
    }
    
    func toast(message: String,
               isShowing: Binding<Bool>,
               duration: TimeInterval) -> some View {
        self.modifier(Toast(message: message,
                            isShowing: isShowing,
                            config: .init(duration: duration)))
    }
}
