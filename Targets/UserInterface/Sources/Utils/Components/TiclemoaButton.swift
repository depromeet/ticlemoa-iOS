//
//  TiclemoaButton.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/12/17.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct TiclemoaButton: View {
    @State private var _isOn = true
    let onTap: (Bool) -> ()
    var isOn: Bool {
        get { self._isOn }
    }
    
    init(isOn: Bool = true, onTap: @escaping (Bool) -> Void) {
        self._isOn = isOn
        self.onTap = onTap
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(isOn ? .ticlemoaBlack : .grey2Line)
                .offset(x: 0, y: 0)
            HStack {
                if isOn {
                    Spacer()
                }
                Circle()
                    .foregroundColor(.white)
                    .padding(1)
                if !isOn {
                    Spacer()
                }
            }
        }
        .frame(width: 39, height: 24)
        .onTapGesture {
            withAnimation {
                _isOn.toggle()
                onTap(isOn)
            }
        }
    }
}
