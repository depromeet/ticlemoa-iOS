//
//  Color+Extension.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/11/28.
//

import SwiftUI

extension Color {
    static let mainGreen = Color("mainGreen")
    static let grey1 = Color("grey1")
    static let grey2 = Color("grey2")
    static let grey3 = Color("grey3")
    static let grey4 = Color("grey4")
    
    
}

// MARK: - BackgroundColor
struct SetupBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.grey1
                .ignoresSafeArea(.all)
            content
        }
    }
}

extension View {
    func setupBackground() -> some View {
        modifier(SetupBackground())
    }
}
