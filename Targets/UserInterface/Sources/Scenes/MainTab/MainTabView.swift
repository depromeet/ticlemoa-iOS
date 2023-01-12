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
    @State private var isSnackBarButtonExisting: Bool = true
    @State private var selection = 0
    
    init() {
        let copiedText: String? = UIPasteboard.general.string
        UserDefaults.standard.set(copiedText, forKey: "isUIPastePermitted")
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                NavigationView {
                    HomeView(viewModel: HomeViewModel(modelContainer: modelContainer))
                }
                .tabItem {
                    selection == 0 ? Image("home_selected") : Image("home_unselected")
                    Text("홈")
                }
                .tag(0)
                .overlay {
                    VStack {
                        Spacer()
                        if UserDefaults.standard.string(forKey: "isUIPastePermitted") != nil {
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
                }
                MyPageView(viewModel: .init(modelContainer: modelContainer))
                .tabItem {
                    selection == 1 ? Image("MypageSelected") : Image("MypageUnselected")
                    Text("마이페이지")
                }
                .tag(1)
            }
            .accentColor(Color.ticlemoaBlack)
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
        MainTabView()
    }
}
