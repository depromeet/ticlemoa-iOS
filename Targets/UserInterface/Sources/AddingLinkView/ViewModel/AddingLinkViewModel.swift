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
    
    func addingButtondidTapped() async -> (message: String, isSuccess: Bool)  {
        do {
            try await modelContainer.articleModel.create(
                AddingArticle(content: memo,
                              title: articleTitle,
                              url: link,
                              isPublic: isPublicSetting),
                tagIds: selectedTags.map { $0.id } )
            return ("추가 완료되었습니다.", true)
        } catch let domainInterfaceError as DomainInterfaceError {
            switch domainInterfaceError {
            case .networkError(code: let code):
                switch code {
                case 400..<500:
                    return ("링크 URL 형식을 맞춰 주세요.", false)
                default:
                    return ("통신에 문제가 있습니다.", false)
                }
            }
        } catch {
            return ("통신에 문제가 있습니다.", false)
        }
    }
}
