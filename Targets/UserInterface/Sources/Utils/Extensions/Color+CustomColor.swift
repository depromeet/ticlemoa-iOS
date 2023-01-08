//
//  Color+CustomColor.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/11/26.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

extension Color {
    static var grey1: Color { return Color("grey1") }
    static var grey2: Color { return Color("grey2") }
    static var grey2Line: Color { return Color("grey2Line") }
    static var grey3: Color { return Color("grey3") }
    static var grey4: Color { return Color("grey4") }
    static var ticlemoaBlack: Color { return Color("ticlemoaBlack") }
    static var ticlemoaPrimary: Color { return Color("ticlemoaPrimary") }
    static var ticlemoaPrimary2: Color { return Color("ticlemoaPrimary2") }
    static var ticlemoaWhite: Color { return Color("ticlemoaWhite") }
    static var secondaryRed: Color { return Color("secondaryRed")}
    static var kakaoYellow: Color { return Color("kakaoYellow")}
    static var darkRed: Color { return Color("darkRed")}
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

public extension View {
    func setupBackground() -> some View {
        modifier(SetupBackground())
    }
}
