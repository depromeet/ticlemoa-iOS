//
//  BottomSheetView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Binding private var isPresent: Bool
    @State private var backgroundOpacity: Double = 0
    @State private var viewYOffset: Double = UIScreen.main.bounds.height
    @Environment(\.dismiss) var dismiss
    var content: () -> (Content)
    let isHandlebarHidden: Bool

    init(isPresent: Binding<Bool>, withHandleBar: Bool = false, @ViewBuilder content: @escaping () -> (Content)) {
        self._isPresent = isPresent
        self.content = content
        self.isHandlebarHidden = !withHandleBar
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(backgroundOpacity)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissWithAnimation()
                }
            
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Capsule()
                            .frame(width: 42, height: 4)
                            .padding(.top, 18)
                            .padding(.bottom, 4)
                            .foregroundColor(isHandlebarHidden ? .clear : .ticlemoaBlack)
                        
                        content()
                        
                        Spacer()
                            .frame(height: geometry.safeAreaInsets.bottom)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.grey1)
                    .cornerRadius(20, corners: .topLeft)
                    .cornerRadius(20, corners: .topRight)
                    .offset(x: 0, y: viewYOffset)
                    .gesture(drag)
                }
                .ignoresSafeArea(.all, edges: [.bottom])
            }
        }
        .onAppear {
            identicalWithAnimation()
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.height > 0 {
                    viewYOffset = value.translation.height
                } else {
                    // TODO: implement if you want to stratch
                }
            }
            .onEnded { value in
                if value.translation.height <= -50 {
                    // TODO: implement if you want to stratch
                } else if value.translation.height >= 50 {
                    dismissWithAnimation()
                } else {
                    identicalWithAnimation()
                }
            }
    }
    
    private func identicalWithAnimation() {
        withAnimation {
            viewYOffset = 0
            backgroundOpacity = 0.4
        }
    }
    
    private func dismissWithAnimation() {
        withAnimation {
            backgroundOpacity = 0
            isPresent = false
            viewYOffset = UIScreen.main.bounds.height
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                dismiss()
            }
        }
    }
}
