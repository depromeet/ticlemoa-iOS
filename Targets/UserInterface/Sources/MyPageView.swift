//
//  MyPageView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/11/30.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
                ProfileSettingView()
            } label: {
                VStack(spacing: 0) {
                    Circle()
                        .frame(width: 59, height: 59)
                        .padding(.top, 18)
                        .padding(.bottom, 12)
                    HStack(spacing: 0) {
                        Text("가나다라마바사")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        Image(systemName: "highlighter")
                    }
                    Text("asdf12345@gmail.com")
                        .tint(.init(uiColor: #colorLiteral(red: 0.8012943864, green: 0.7903164029, blue: 0.7607244849, alpha: 1)))
                        .padding(.top, 2)
                        .padding(.bottom, 14)
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 81)
            
            VStack(spacing: 0) {
                MyPageNavigationView(imageName: "bell", title: "알림")
                MyPageNavigationView(imageName: "info.circle", title: "서비스 정보")
                MyPageNavigationView(imageName: "questionmark.circle", title: "문의하기")
            }
            .padding()
            
            HStack {
                HStack {
                    Text("앱 버전정보 1.1.1")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("업데이트")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(5)
                        .padding(.horizontal, 7)
                        .background(Capsule())
                }
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 13)
            
            Button {
                Void()
            } label: {
                HStack {
                    Text("로그아웃")
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 13)

            Button(role: .destructive) {
                Void()
            } label: {
                HStack {
                    Text("계정삭제")
                    Spacer()
                }
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 13)
            
            Spacer()
        }
        .navigationTitle("마이페이지")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyPageNavigationView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        NavigationLink {
            EmptyView()
        } label: {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: imageName)
                    Text(title)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.black)
                .padding(.vertical)
                Divider()
            }
        }
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationLink {
                MyPageView()
            } label: {
                Text("Button")
            }

        }
        MyPageView()
    }
}
