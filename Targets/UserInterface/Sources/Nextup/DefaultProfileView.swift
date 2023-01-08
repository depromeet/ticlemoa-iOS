//
//  DefaultProfileView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/12/24.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

// icon 사용예시
// DefaultProfileView()
//    .frame(width: 25.45, height: 25.45)

struct DefaultProfileView: View {
    var body: some View {
        Circle()
            .foregroundColor(.grey4)
            .overlay(
                DefaultProfileShape()
                    .foregroundColor(.grey2)
            )
            .clipShape(Circle())
    }
}

private struct DefaultProfileShape: Shape {
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height)
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: diameter * 24.5 / 59),
            radius: diameter * 21 / 108 ,
            startAngle: .zero,
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.addEllipse(
            in: CGRect(
                origin: CGPoint(
                    x: rect.size.width * 8.43 / 59,
                    y: rect.size.height * 40.03 / 59
                ),
                size: CGSize(
                    width: rect.size.width * 42.14 / 59,
                    height: rect.size.height * 27.39 / 59
                )
            )
        )
        return path
    }
}

struct DefaultProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultProfileView()
    }
}
