//
//  AlertSettingView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/12/17.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct AlertSettingView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 12)
            AlertSettingButtonView(title: "푸시알림") { isOn in
                print("button tapped with value = \(isOn)")
            }
            Spacer()
        }
        .setupBackground()
        .navigationTitle("알림")
    }
}

fileprivate struct AlertSettingButtonView: View {
    let title: String
    let onTap: (Bool) -> ()
    
    init(title: String, onTap: @escaping (Bool) -> Void) {
        self.title = title
        self.onTap = onTap
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .fontWeight(.medium)
            Spacer()
            TiclemoaButton(onTap: onTap)
        }
        .foregroundColor(.ticlemoaBlack)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}
