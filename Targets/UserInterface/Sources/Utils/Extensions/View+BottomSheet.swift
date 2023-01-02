//
//  View+BottomSheet.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/12/20.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

extension View {
    func ticlemoaBottomSheet(isPresented: Binding<Bool>, withHandleBar: Bool = false, @ViewBuilder content: @escaping () -> (some View)) -> some View {
        let keyWindow = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
        
        let bottomSheetHostingController = UIHostingController(rootView: BottomSheetView(isPresent: isPresented, withHandleBar: withHandleBar, content: content))
        bottomSheetHostingController.modalPresentationStyle = .overCurrentContext
        bottomSheetHostingController.view.backgroundColor = .clear
        bottomSheetHostingController.definesPresentationContext = true
        
        return self.onChange(of: isPresented.wrappedValue) { newValue in
            newValue ?
            keyWindow?.rootViewController?.present(bottomSheetHostingController, animated: false) : Void()
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

