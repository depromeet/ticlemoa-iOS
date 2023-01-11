//
//  MyPageViewModel.swift
//  UserInterface
//
//  Created by 김용우 on 2023/01/08.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI
import DomainInterface
import Combine

final class MyPageViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    @Published var isLoggedIn: LoginUser? = nil
    @Published var nickName: String?
    @Published var email: String?
    @Published var profileImageURL: URL?
    @AppStorage("Moamoa.userProfileImageURL") private var userProfileImageURL: URL?
    private var anyCancellables: [AnyCancellable] = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.setupBinding()
    }
    
    func updateProfile() {
        profileImageURL = userProfileImageURL
    }
    
    func accountDeletionConfirmButtonTouched() {
        Task {
            let isDeletionSucceed = await modelContainer.loginModel.deleteAccount()
            if isDeletionSucceed {
                
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

        modelContainer
            .loginModel
            .userDataPublisher
            .receive(on: RunLoop.main)
            .assign(to: &self.$isLoggedIn)
    }
}
