//
//  Collapsible.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct Collapsible<Content: View>: View {
//    @State var label: () -> Text
    @State var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? CGFloat(tagHeight) : 500)
            .clipped()
            .animation(.easeIn)
            .transition(.slide)
            .background {
                VStack {
                    Button(
                        action: { self.collapsed.toggle() },
                        label: {
                            HStack {
        //                        self.label()
        //                            .padding(.leading, 16)
                                Spacer()
                                Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                                    .padding(.trailing, 16)
                                    .background { Color.red }
                            }
                            .padding(.bottom, 1)
                            .background(Color.white.opacity(0.01))
                        }
                    )
                    Spacer()
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
