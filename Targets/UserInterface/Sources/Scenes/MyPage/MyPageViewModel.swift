//
//  MyPageViewModel.swift
//  UserInterface
//
//  Created by 김용우 on 2023/01/08.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

final class MyPageViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    @Published var profileImageURL: URL?
    @AppStorage("Moamoa.userProfileImageURL") private var userProfileImageURL: URL?
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func updateProfile() {
        profileImageURL = userProfileImageURL
    }
}
