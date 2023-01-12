//
//  AddingLinkViewModel.swift
//  Ticlemoa
//
//  Created by Joseph Cha on 2022/12/09.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

import DomainInterface

final class AddingLinkViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    
    @Published var link: String = ""
    @Published var articleTitle: String = ""
    @Published var articleThumbNail: String = "ArticlePlaceholder"
    @Published var memo: String = ""
    @Published var isPublicSetting: Bool = false
    @Published var selectedTags: [Tag] = []
    private var anyCancellables: [AnyCancellable] = []
    
    let fromWhichButton: FromWhichButton
    var isModifying: Bool = false
    var modifiedArticleId: Int?
    
    // TODO: userId = LoginUserData.shared 참고
    
    init(modelContainer: ModelContainer, fromWhichButton: FromWhichButton) {
        self.modelContainer = modelContainer
        self.fromWhichButton = fromWhichButton
        
        switch fromWhichButton {
        case .snackBar:
            self.link = UserDefaults.standard.string(forKey: "isUIPastePermitted") ?? ""
        case .modifyingButton(let article):
            self.isModifying = true
            self.link = article.url
            self.articleTitle = article.title
            self.memo = article.content
            self.isPublicSetting = article.isPublic
            self.modifiedArticleId = article.id
            self.modelContainer.tagModel.itemsPublisher
                .receive(on: RunLoop.main)
                .sink { tags in
                    self.selectedTags = tags.filter { article.tagIds.contains($0.id) }
                }
                .store(in: &anyCancellables)
        default:
            break
        }
    }
    
    func addingButtondidTapped() async -> (message: String, isSuccess: Bool)  {
        do {
            let addingArticle = AddingArticle(
                content: memo,
                title: articleTitle,
                url: link,
                isPublic: isPublicSetting,
                id: isModifying ? self.modifiedArticleId ?? 0 : 0 
            )
            
            if isModifying {
                try await modelContainer.articleModel.update(addingArticle, tagIds: selectedTags.map{ $0.id })
            } else {
                try await modelContainer.articleModel.create(addingArticle, tagIds: selectedTags.map { $0.id } )
            }
            return (isModifying ? "수정이 완료되었습니다." : "추가 완료되었습니다.", true)
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
