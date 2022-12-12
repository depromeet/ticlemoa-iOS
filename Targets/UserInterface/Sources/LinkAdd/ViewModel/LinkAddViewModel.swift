//
//  LinkAddViewModel.swift
//  Ticlemoa
//
//  Created by Joseph Cha on 2022/12/09.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import SwiftUI

final class LinkAddViewModel: ObservableObject {
    @Published var link: String = ""
    @Published var articleTitle: String = "아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목아티클제목"
    @Published var articleThumbNail: String = "ArticlePlaceholder"
    @Published var memo: String = ""
    @Published var isPublicSetting: Bool = false
    @Published var tags: [String] = ["태그명"]
    private let fromWhichButton: FromWhichButton
    
    init(fromWhichButton: FromWhichButton) {
        self.fromWhichButton = fromWhichButton
        if let copiedlink = UIPasteboard.general.string, fromWhichButton == .snackBar {
            self.link = copiedlink
        }
    }
}
