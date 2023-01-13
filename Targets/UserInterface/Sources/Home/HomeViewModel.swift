//
//  HomeViewModel.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/11.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import SwiftUI
import DomainInterface
import Combine

final class HomeViewModel: ObservableObject {
    @ObservedObject var modelContainer: ModelContainer
    @Published var tags: [Tag] = []
    @Published var isTagManagingViewPresented: Bool = false
    @Published var selectedTag: Tag? {
        didSet {
            Task {
                if selectedTag?.tagName == "전체" {
                    try? await modelContainer.articleModel.fetch(tagId: nil)
                } else {
                    try? await modelContainer.articleModel.fetch(tagId: selectedTag?.id)
                }
            }
        }
    }
    
    private var anyCancellables: [AnyCancellable] = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.modelContainer.tagModel.itemsPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] tagItems in
                self?.tags = [WholeTag()] + tagItems
            }
            .store(in: &anyCancellables)
        
        Task { [weak self] in
            try? await modelContainer.tagModel.read()
            try? await modelContainer.articleModel.fetch(tagId: nil)
            self?.selectedTag = tags.first
        }
    }
}

// MARK: UI Configure
extension HomeViewModel {
//    func tagButtonColor(by row: HomeTag) -> Color {
//        self.selectedTag?.tag.id == row.tag.id ? Color.white : Color.grey4
//    }
//
//    func tagBackgroundColor(by row: HomeTag) -> Color {
//        self.selectedTag?.tag.id == row.tag.id ? Color.ticlemoaBlack : Color.grey2
//    }
}

private extension HomeViewModel {
    struct WholeTag: Tag {
        let id: Int = 0
        let userId: Int = 0
        let tagName: String = "전체"
    }
}
