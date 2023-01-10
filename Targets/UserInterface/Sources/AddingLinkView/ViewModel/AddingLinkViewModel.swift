//
//  AddingLinkViewModel.swift
//  Ticlemoa
//
//  Created by Joseph Cha on 2022/12/09.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import SwiftUI

import DomainInterface

final class AddingLinkViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    
    @Published var link: String = ""
    @Published var articleTitle: String = "아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목"
    @Published var articleThumbNail: String = "ArticlePlaceholder"
    @Published var memo: String = ""
    @Published var isPublicSetting: Bool = false
    @Published var selectedTags: [Tag] = []
    let fromWhichButton: FromWhichButton
    
    // TODO: userId = LoginUserData.shared 참고
    
    init(modelContainer: ModelContainer, fromWhichButton: FromWhichButton) {
        self.modelContainer = modelContainer
        self.fromWhichButton = fromWhichButton
        
        if let copiedlink = UIPasteboard.general.string, fromWhichButton == .snackBar {
            self.link = copiedlink
        }
    }
}
