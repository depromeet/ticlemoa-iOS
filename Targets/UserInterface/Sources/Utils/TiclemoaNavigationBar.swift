//
//  TiclemoaNavigationBar.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct TiclemoaNavigationBar<Item: View>: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    private let title: String
    private let trailingItem: () -> Item
    
    init(title: String, @ViewBuilder trailingItem: @escaping () -> Item) {
        self.title = title
        self.trailingItem = trailingItem
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack {
                HStack(alignment: .center) {
                    Button {
                        dismiss()
                    } label: {
                        Image("arrow")
                            .frame(width: 9.29, height: 15.8)
                    }
                    .padding(.leading, 26.52)
                    Spacer()
                    trailingItem().padding(.trailing, 20)
                }
                Text(title)
                    .customFont(18, .bold)
            }
            .frame(height: 56)
            Spacer()
            content
                .toolbar(.hidden)
            Spacer()
        }
    }
}
