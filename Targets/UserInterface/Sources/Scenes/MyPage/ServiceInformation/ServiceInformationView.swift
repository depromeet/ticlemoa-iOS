//
//  ServiceInformationView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/12/15.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct ServiceInformationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 12)
            Link(destination: URL(string: "https://www.notion.so/Ticlemoa-d7a3fca0886b4508b2fba46b60c4616b")!) {
                ServiceInformationLabel(title: "개인정보 처리방침")
            }
            NavigationLink {
                VStack {
                    Text("Swift Collection")
                        .pretendFont(.title1)
                    Text(swiftCollection)
                        .pretendFont(.body1)
                }
                .navigationBarBackButtonHidden(true)
                .ticlemoaNavigationBar(title: "오픈소스", image: "arrow")
            } label: {
                ServiceInformationLabel(title: "오픈소스")
            }
            Spacer()
        }
        .ticlemoaNavigationBar(title: "서비스 정보", image: "arrow")
        .setupBackground()
    }
    
    var swiftCollection: String = """
    // This source file is part of the Swift Collections open source project
    //
    // Copyright (c) 2021 Apple Inc. and the Swift project authors
    // Licensed under Apache License v2.0 with Runtime Library Exception
    //
    // See https://swift.org/LICENSE.txt for license information
    """
}

fileprivate struct ServiceInformationLabel: View {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .fontWeight(.medium)
            Spacer()
            Image("Arrow.right")
        }
        .foregroundColor(.black)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}
