//
//  ProfileSettingViewModel.swift
//  UserInterface
//
//  Created by 김용우 on 2023/01/08.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI

final class ProfileSettingViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
}
