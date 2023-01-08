//
//  ShakeAnimation.swift
//  API
//
//  Created by 김우성 on 2023/01/08.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}


/* Example */
private struct ShakeView: View {
    @State var attempts: Int = 0

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.pink)
                .frame(width: 200, height: 100)
                .modifier(Shake(animatableData: CGFloat(attempts)))
            Spacer()
            Button(action: {
                withAnimation(.default) {
                    self.attempts += 1
                }

            }, label: { Text("Login") })
        }
    }
}

struct ShakeView_Previews: PreviewProvider {
    static var previews: some View {
        ShakeView()
    }
}
