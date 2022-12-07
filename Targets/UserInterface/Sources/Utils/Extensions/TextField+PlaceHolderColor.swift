//
//  TextField+PlaceHolderColor.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/12/06.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

extension TextField {
    func placeholder(
        _ text: String,
        when shouldShow: Bool,
        color: Color?,
        alignment: Alignment = .leading) -> some View {
            ZStack(alignment: alignment) {
                Text(text)
                    .foregroundColor(color)
                    .opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
