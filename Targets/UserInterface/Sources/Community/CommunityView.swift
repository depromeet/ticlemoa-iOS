//
//  CommunityView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct CommunityView: View {
    @AppStorage("Moamoa.isUserVisit") private var isUserVisit = false
    @State private var isBottomsheetPresented = false
    
    var body: some View {
        Button {
            isBottomsheetPresented = true
        } label: {
            Text("Community...")
        }
        .ticlemoaBottomSheet(isPresented: $isBottomsheetPresented) {
            VStack(alignment: .center, spacing: 0) {
                Text("모아모아")
                    .foregroundColor(.ticlemoaBlack)
                    .customFont(weight: 700, size: 18, lineHeight: 27)
                    .padding(.vertical, 16 + 4.5)
                Spacer()
                    .frame(height: 10)
                Image("MoamoaImage")
                Spacer()
                    .frame(height: 24)
                HStack(spacing: 0) {
                    Text("모아모아에서 경험할 수 있는 것")
                        .foregroundColor(.ticlemoaBlack)
                        .customFont(weight: 600, size: 18, lineHeight: 27)
                    Spacer()
                }
                .padding(.vertical, 4.5)
                Spacer()
                    .frame(height: 4)
                HStack(spacing: 0) {
                    Text("내 태그에 속해있는 아티클과 관련된 아티클을 볼 수 있어요.")
                        .foregroundColor(.grey4)
                        .customFont(weight: 400, size: 14, lineHeight: 21)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Spacer()
                        
                }
                .padding(.vertical, 3.5)
            }
            .padding(.horizontal, 36)
            
            Button {
                isBottomsheetPresented = false
            } label: {
                HStack {
                    Spacer()
                    Text("보러가기")
                        .customFont(weight: 700, size: 16, lineHeight: 24)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 16 + 4)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.ticlemoaBlack)
                )
            }
            .padding(.top, 36)
            .padding(.bottom, 16)
            .padding(.horizontal, 20)
        }
        .onAppear {
            isBottomsheetPresented = !isUserVisit
            isUserVisit = true
        }
    }
}

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
