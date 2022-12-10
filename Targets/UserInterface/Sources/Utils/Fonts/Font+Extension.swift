//
//  Font+Extension.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

public enum PretendardFontWeight: String {
    case regular = "Regular"
    case thin = "Thin"
    case extraLight = "ExtraLight"
    case light = "Light"
    case medium = "Medium"
    case semiBold = "SemiBold"
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case black = "Black"
}

public extension Text {
    func customFont(
        _ size: CGFloat = 12,
        _ weight: PretendardFontWeight = .regular
    ) -> Text {
        self.font(.custom("Pretendard-\(weight.rawValue)", size: size))
    }
}

