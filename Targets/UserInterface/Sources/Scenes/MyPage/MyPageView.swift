//
//  MyPageView.swift
//  UserInterface
//
//  Created by Shin Jae Ung on 2022/11/30.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var modelContainer: ModelContainer
    @ObservedObject var viewModel: MyPageViewModel
    @State private var isAccountDeleteButtonTouched: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("마이페이지")
                    .customFont(weight: 700, size: 18, lineHeight: 22, style: .bold)
                Spacer()
            }
            .frame(height: 56)
            
            NavigationLink {
                ProfileSettingView(viewModel: ProfileSettingViewModel(modelContainer: modelContainer))
                    .navigationBarBackButtonHidden(true)
            } label: {
                VStack(spacing: 0) {
                    Group {
                        if let path = viewModel.profileImageURL?.path, let uiImage = UIImage(contentsOfFile: path) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                        } else {
                            DefaultProfileView()
                        }
                    }
                    .frame(width: 59, height: 59)
                    .padding(.top, 24)
                    .padding(.bottom, 12)
                    HStack(spacing: 2) {
                        Text(viewModel.nickName ?? "확인할 수 없음")
                            .pretendFont(.subhead3)
                            .foregroundColor(.ticlemoaBlack)
                        Image("Pen")
                            .frame(width: 20, height: 20)
                    }
                    Text(viewModel.email ?? "확인할 수 없음")
                        .pretendFont(.subhead2)
                        .tint(.grey3)
                        .padding(.top, 4)
                        .padding(.bottom, 19.5)
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            .padding(.horizontal, 81)
            
            VStack(spacing: 0) {
                MyPageNavigationView(imageName: "Information", title: "서비스 정보") {
                    ServiceInformationView()
                        .navigationBarBackButtonHidden(true)
                }
                MyPageNavigationView(imageName: "QuestionMark", title: "문의하기") {
                    EmptyView()
                }
            }
            .padding(.bottom, 16)
            
            Button {
                Void()
            } label: {
                HStack {
                    Text("앱 버전정보 1.1.1")
                        .customFont(weight: 400, size: 14, lineHeight: 21, style: .medium)
                        .foregroundColor(.grey4)
                        .padding(.top, 13)
                        .padding(.bottom, 14)
                    Spacer()
                    Group {
                        if true {
                            Text("업데이트")
                                .customFont(weight: 600, size: 12, lineHeight: 18)
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 12)
                                .background(
                                    Capsule()
                                        .foregroundColor(.ticlemoaBlack)
                                )
                        } else {
                            Text("최신버전")
                                .foregroundColor(.grey3)
                                .customFont(weight: 400, size: 14, lineHeight: 21)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            Button {
                Void()
            } label: {
                HStack {
                    Text("로그아웃")
                        .customFont(weight: 400, size: 14, lineHeight: 21, style: .medium)
                        .foregroundColor(.grey4)
                        .padding(.top, 13)
                        .padding(.bottom, 14)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            
            Button {
                isAccountDeleteButtonTouched = true
            } label: {
                HStack {
                    Text("계정삭제")
                        .customFont(weight: 400, size: 14, lineHeight: 21, style: .medium)
                        .foregroundColor(.secondaryRed)
                        .padding(.top, 13)
                        .padding(.bottom, 14)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.updateProfile()
        }
        .setupBackground()
//        .ticlemoaNavigationBar(title: "마이페이지")
        .ticlemoaBottomSheet(isPresented: $isAccountDeleteButtonTouched) {
            MyPageAccountDeletingView()
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
                    Image(imageName)
                    Text(title)
                        .customFont(weight: 400, size: 16, lineHeight: 24, style: .medium)
                    Spacer()
                    Image("Arrow.right")
                }
                .foregroundColor(.ticlemoaBlack)
                .padding(.vertical, 16)
                Divider()
                    .foregroundColor(.grey2)
            }
            .padding(.horizontal, 20)
        }
    }
}

fileprivate struct MyPageAccountDeletingView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("계정삭제")
                .font(.system(size: 18))
                .fontWeight(.bold)
                .padding(.top, 20.5)
                .padding(.bottom, 30.5)
            
            Rectangle()
                .border(.red)
                .foregroundColor(.secondaryRed)
                .frame(height: 133)
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
                            .foregroundColor(.ticlemoaBlack)
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
