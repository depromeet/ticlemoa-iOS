//
//  PageControl.swift
//  UserInterface
//
//  Created by 김우성 on 2023/01/07.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

struct PageControl: View {

    @Binding var selectedPage: Int

    var pages: Int
    var circleDiameter: CGFloat
    var circleMargin: CGFloat

    private var circleRadius: CGFloat { circleDiameter / 2}
    private var pageIndex: CGFloat { CGFloat(selectedPage - 1) }

    private var currentPosition: CGFloat {
        // 첫 번째 포지션 연산
        let stackWidth = circleDiameter * CGFloat(pages) + circleMargin * CGFloat(pages - 1)
        let halfStackWidth = stackWidth / 2
        let iniPosition = -halfStackWidth + circleRadius

        // 다음 인디케이터 이동을 위한 연산
        let distanceToNextPoint = circleDiameter + circleMargin

        // 두 값을 합쳐서 현재 위치 리턴
        return iniPosition + (pageIndex * distanceToNextPoint)
    }

    var body: some View {
        ZStack {
            // 모든 페이지 인덱스 인디케이터
            HStack(spacing: circleMargin) {
                ForEach(0 ..< pages) { _ in
                    Circle()
                        .foregroundColor(Color.grey2Line)
                        .frame(width: circleDiameter, height: circleDiameter)
                }
            }

            // 현재 페이지 인덱스 인디케이터
            Capsule(style: RoundedCornerStyle.continuous)
                .foregroundColor(.grey4)
                .frame(width: circleDiameter * 1.7, height: circleDiameter)
                .offset(x: currentPosition)
                .animation(.linear(duration: 0.3))
        }
    }
}

struct PageControlPreview: View {

    var pages: Int = 3
    @State var selectedPage: Int = 1

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    selectedPage = selectedPage - 1
                }, label: {
                    Image(systemName: "arrow.left.square.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                })

                Button(action: {
                    selectedPage = selectedPage + 1
                }, label: {
                    Image(systemName: "arrow.right.square.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                })
            }

            PageControl(selectedPage: $selectedPage, pages: pages, circleDiameter: 15.0, circleMargin: 10.0)
        }
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
        PageControlPreview()
    }
}
