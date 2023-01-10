//
//  MainTabView.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/04.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var modelContainer: ModelContainer
    @State private var isSnackBarButtonExisting: Bool = UIPasteboard.general.string != nil // 복사된 텍스트가 있을 경우, true
    @Binding var isLogin: Bool
    
    init(isLogin: Binding<Bool>) {
        self._isLogin = isLogin
    }
    
    var body: some View {
        NavigationView {
            TabView {
                HomeView(viewModel: HomeViewModel(modelContainer: modelContainer))
                .tabItem {
                    Tab.home.imageItem
                    Tab.home.textItem
                }
                .overlay {
                    VStack {
                        Spacer()
                        if isSnackBarButtonExisting {
                            NavigationLink(
                                destination: AddingLinkView(modelContainer: modelContainer, fromWhere: .snackBar),
                                label: {
                                    HStack {
                                        Text("복사한 링크 추가하기")
                                            .font(.system(size: 14))
                                            .foregroundColor(.grey1)
                                            .padding(.leading, 16)
                                        Spacer()
                                        Button {
                                            isSnackBarButtonExisting = false
                                        } label: {
                                            Image("CloseButton")
                                                .frame(width: 13.67, height: 13.67)
                                                .padding(.trailing, 15.19)
                                        }
                                    }
                                    .frame(height: 44)
                                    .background(Color.ticlemoaBlack)
                                })
                            .cornerRadius(6.0)
                            .padding(.horizontal, 32)
                            .padding(.bottom, 32)
                        }
                    }
                }
                NavigationView {
                    MyPageView(viewModel: .init(modelContainer: modelContainer, isLogin: $isLogin))
                }
                .tabItem {
                    Tab.myPage.imageItem
                    Tab.myPage.textItem
                }
            }
            .overlay {
                VStack {
                    Spacer()
                    NavigationLink(
                        destination: AddingLinkView(modelContainer: modelContainer, fromWhere: .naviBar),
                        label: {
                            Image("add")
                        })
                    Spacer()
                        .frame(height: 16)
                }
            }
        }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(isLogin: .constant(true))
    }
}
