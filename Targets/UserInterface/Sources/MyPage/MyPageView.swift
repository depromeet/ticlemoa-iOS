//
//  MyPageView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/11/30.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct MyPageView: View {
    @State private var isAccountDeleteButtonTouched: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
//                ProfileSettingView()
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
                        .tint(.grey3)
                        .padding(.top, 2)
                        .padding(.bottom, 14)
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 81)
            
            VStack(spacing: 0) {
                MyPageNavigationView(imageName: "bell", title: "알림") {
                    EmptyView()
                }
                MyPageNavigationView(imageName: "info.circle", title: "서비스 정보") {
                    ServiceInformationView()
                }
                MyPageNavigationView(imageName: "questionmark.circle", title: "문의하기") {
                    EmptyView()
                }
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
                isAccountDeleteButtonTouched = true
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
        .sheet(isPresented: $isAccountDeleteButtonTouched) {
            if #available(iOS 16.0, *) {
                MyPageAccountDeletingView()
                    .presentationDetents([.medium])
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

fileprivate struct MyPageNavigationView<Destination: View>: View {
    let imageName: String
    let title: String
    let destination: () -> Destination
    
    init(imageName: String, title: String, destination: @escaping () -> Destination) {
        self.imageName = imageName
        self.title = title
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination()
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

fileprivate struct MyPageAccountDeletingView: View {
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .foregroundColor(.black)
                .frame(width: 42, height: 4)
                .padding(18)
            Text("계정삭제")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .padding(.top, 6.5)
                .padding(.bottom, 30.5)
            Spacer()
                .background(Rectangle())
                .padding(.horizontal, 36)
            VStack(spacing: 0) {
                HStack {
                    Text("정말로 계정을 삭제하시겠어요?")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.vertical, 4.5)
                .padding(.bottom, 4)
                
                HStack {
                    Text("N개의 콘텐츠가 모두 삭제되고, 계정은 복구할 수 없어요")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.grey4)
                    Spacer()
                }
                .padding(.vertical, 3.5)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 36)
            HStack(spacing: 11) {
                Button {
                    Void()
                } label: {
                    HStack {
                        Spacer()
                        Text("취소")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundColor(.grey2Line)
                    )
                }
                Button {
                    Void()
                } label: {
                    HStack {
                        Spacer()
                        Text("삭제")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundColor(.secondaryRed)
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
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
