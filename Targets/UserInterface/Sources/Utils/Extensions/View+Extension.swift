//
//  View+Extension.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

extension View {
    func ticlemoaNavigationBar(
        title: String,
        image: String,
        @ViewBuilder trailingItem: @escaping () -> (some View) = { EmptyView() }
    ) -> some View {
        return modifier(TiclemoaNavigationBar(title: title, image: image, trailingItem: trailingItem))
    }
}
