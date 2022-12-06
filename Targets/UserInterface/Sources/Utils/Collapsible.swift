//
//  Collapsible.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct Collapsible<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        self.label()
                            .padding(.leading, 16)
                        Spacer()
                        Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                            .padding(.trailing, 16)
                    }
                    .padding(.bottom, 1)
                    .background(Color.white.opacity(0.01))
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            VStack {
                self.content()
//                    .setupBackground()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
//            .animation(.easeIn)
            .transition(.slide)
        }
    }
}
