//
//  ProfileSettingViewModel.swift
//  UserInterface
//
//  Created by 김용우 on 2023/01/08.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI
import Combine

final class ProfileSettingViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    @Published var isConfirmationDialogOpen: Bool = false
    @Published var isImagePickerOpen: Bool = false
    @Published var profileImageURL: URL?
    @Published var nickname: String = ""
    @Published var isPresented: Bool = true
    @Published var isSavable: Bool = false
    @AppStorage("Moamoa.userProfileImageURL") private var userProfileImageURL: URL?
    private var anyCancellables: [AnyCancellable] = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.profileImageURL = userProfileImageURL
        self.setupBinding()
    }
    
    func profileImageTouched() {
        isConfirmationDialogOpen = true
    }
    
    func nicknameTextfieldChanged() {
        nickname = String(nickname.prefix(10))
    }
    
    func selectPhotoInAlbumButtonTouched() {
        isImagePickerOpen = true
    }
    
    func updateProfileImage(fromUrl url: URL) {
        profileImageURL = url
    }
    
    func resetImage() {
        profileImageURL = nil
    }
    
    func saveButtonTouched() {
        if isSavable {
            userProfileImageURL = profileImageURL
            modelContainer.loginModel.nicknameChangeTo(nickname)
            isPresented = false
        } else {
            // TODO: 없을 때 어떻게 해야할지 결정해야 함
        }
    }
    
    private func setupBinding() {
        modelContainer.loginModel.userDataPublisher.sink { [weak self] loginUser in
            if let savedNickname = loginUser?.nickName {
                self?.nickname = savedNickname
            }
        }.store(in: &anyCancellables)
        
        $nickname.sink { [weak self] string in
            guard let self = self else { return }
            self.isSavable = !self.nickname.isEmpty && !self.nickname.contains(" ")
        }.store(in: &anyCancellables)
    }
}
