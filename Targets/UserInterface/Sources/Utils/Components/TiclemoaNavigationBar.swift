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
    private let image: String
    
    init(title: String, image: String, @ViewBuilder trailingItem: @escaping () -> Item) {
        self.title = title
        self.image = image
        self.trailingItem = trailingItem
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack {
                HStack(alignment: .center) {
                    Button {
                        dismiss()
                    } label: {
                        Image(image)
                            .frame(width: 9.29, height: 15.8)
                    }
                    .padding(.leading, 26.52)
                    Spacer()
                    trailingItem().padding(.trailing, 20)
                }
                Text(title)
                    .customFont(weight: 700, size: 18, lineHeight: 22)
            }
            .frame(height: 56)
            Spacer(minLength: 0)
            content
                .navigationBarBackButtonHidden(true)
            Spacer(minLength: 0)
        }
        .setupBackground()
    }
}
