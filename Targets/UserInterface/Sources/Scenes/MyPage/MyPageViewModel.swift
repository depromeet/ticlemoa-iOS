//
//  MyPageViewModel.swift
//  UserInterface
//
//  Created by 김용우 on 2023/01/08.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI
import Combine

final class MyPageViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    @Published var nickName: String?
    @Published var email: String?
    @Published var profileImageURL: URL?
    @AppStorage("Moamoa.userProfileImageURL") private var userProfileImageURL: URL?
    @Binding var isLogin: Bool
    private var anyCancellables: [AnyCancellable] = []
    
    init(modelContainer: ModelContainer, isLogin: Binding<Bool>) {
        self.modelContainer = modelContainer
        self._isLogin = isLogin
        self.setupBinding()
    }
    
    func updateProfile() {
        profileImageURL = userProfileImageURL
    }
    
    func accountDeletionConfirmButtonTouched() {
        Task {
            let isDeletionSucceed = await modelContainer.loginModel.deleteAccount()
            if isDeletionSucceed {
                isLogin = false
                userProfileImageURL = nil
            } else {

            }
        }
    }
    
    private func setupBinding() {
        modelContainer.loginModel.userDataPublisher.sink { [weak self] loginUser in
            self?.nickName = loginUser?.nickName
            self?.email = loginUser?.mail
        }.store(in: &anyCancellables)
    }
}
