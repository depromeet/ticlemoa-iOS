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
            ServiceInformationNavigationLink(title: "개인정보 처리방침") {
                EmptyView()
            }
            ServiceInformationNavigationLink(title: "오픈소스") {
                EmptyView()
            }
            Spacer()
        }
        .ticlemoaNavigationBar(title: "서비스 정보")
        .setupBackground()
    }
}

fileprivate struct ServiceInformationNavigationLink<Destination: View>: View {
    let title: String
    let destination: () -> Destination
    
    init(title: String, destination: @escaping () -> Destination) {
        self.title = title
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination()
        } label: {
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
}
