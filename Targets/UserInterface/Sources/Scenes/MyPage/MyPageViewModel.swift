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
import MessageUI

final class MyPageViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    @Published var isLoggedIn: LoginUser? = nil
    @Published var nickName: String?
    @Published var email: String?
    @Published var profileImageUrl: URL?
    @Published var isMailViewPresented: Bool = false
    @Published var isMailViewAlertPresented: Bool = false
    @Published var mailResult: Result<MFMailComposeResult, Error>? = nil
    @Published var numberOfArticles: Int = 0
    @AppStorage("Moamoa.userProfileImageURL") private var userProfileImageURL: URL?
    private var anyCancellables: [AnyCancellable] = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.setupBinding()
    }
    
    func updateProfile() {
        profileImageUrl = userProfileImageURL
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
        modelContainer.loginModel.userDataPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] loginUser in
            self?.nickName = loginUser?.nickName
            self?.email = loginUser?.mail
        }.store(in: &anyCancellables)
        
        modelContainer.articleModel.itemsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] articles in
                self?.numberOfArticles = articles.count
            }.store(in: &anyCancellables)

        modelContainer
            .loginModel
            .userDataPublisher
            .receive(on: RunLoop.main)
            .assign(to: &self.$isLoggedIn)
    }
}
