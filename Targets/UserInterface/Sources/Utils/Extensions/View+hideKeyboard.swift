//
//  View+hideKeyboard.swift
//  UserInterface
//
//  Created by Joseph Cha on 2022/12/12.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

extension View {
    func hideKeyboard() -> some View {
        ZStack {
            Color.white.opacity(0.000000001)
            .ignoresSafeArea()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            self
        }
    }
}
