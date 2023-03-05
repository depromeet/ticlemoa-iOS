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
    struct HomeViewTag: Tag, Identifiable, Hashable {
        var id: Int
        var userId: Int
        var tagName: String
        var size: CGFloat = 0
    }
    
    @ObservedObject var modelContainer: ModelContainer
    @Published var rows: [[HomeViewTag]] = []
    @Published var tags: [HomeViewTag] = []
    @Published var isTagManagingViewPresented: Bool = false
    @Published var selectedTag: HomeViewTag? {
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
                self?.tags = [HomeViewTag(id: 0, userId: 0, tagName: "전체")] + tagItems.map { HomeViewTag(id: $0.id, userId: $0.userId, tagName: $0.tagName) }
                #if DEBUG
                self?.tags = self?.mockTag ?? []
                #endif
                self?.calculateRow()
            }
            .store(in: &anyCancellables)
        
        Task { [weak self] in
            try? await modelContainer.tagModel.read()
            try? await modelContainer.articleModel.fetch(tagId: nil)
            self?.selectedTag = tags.first
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetchArticle),
            name: .filterArticleList,
            object: nil
        )
        
    }
    
    @objc private func fetchArticle(notification: Notification? = nil) {
        Task {
            do {
                if selectedTag?.tagName == "전체" {
                    try await modelContainer.articleModel.fetch(tagId: nil)
                } else {
                    try await modelContainer.articleModel.fetch(tagId: selectedTag?.id)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func calculateRow() {
        var rows: [[HomeViewTag]] = []
        var currentRow: [HomeViewTag] = []
        
        var totalWidth: CGFloat = 0
        let screenWidth = UIScreen.screenWidth - (20 + 53) // leading padding + 위쪽 화살표 width
        let tagSpaceing: CGFloat = 10 + 24 // 각 chip간 width + chip의 horizontal padding
        
        if !tags.isEmpty{
            for index in 0..<tags.count{
                self.tags[index].size = tags[index].tagName.getSize()
            }
            
            tags.forEach{ tag in
                totalWidth += (tag.size + tagSpaceing)
                
                if totalWidth > screenWidth {
                    totalWidth = (tag.size + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                } else {
                    currentRow.append(tag)
                }
            }
            
            if !currentRow.isEmpty{
                rows.append(currentRow)
                currentRow.removeAll()
            }
            
            self.rows = rows
        } else {
            self.rows = []
        }
    }

#if DEBUG
    var mockTag: [HomeViewTag] =
    [
        HomeViewTag(id: 0, userId: 0, tagName: "전체"),
        HomeViewTag(id: 1, userId: 1, tagName: "iOS"),
        HomeViewTag(id: 2, userId: 2, tagName: "Swift"),
        HomeViewTag(id: 3, userId: 3, tagName: "디자인"),
        HomeViewTag(id: 4, userId: 4, tagName: "웹 풀스택"),
        HomeViewTag(id: 5, userId: 5, tagName: "시사"),
        HomeViewTag(id: 6, userId: 6, tagName: "사회"),
        HomeViewTag(id: 7, userId: 7, tagName: "경제"),
        HomeViewTag(id: 8, userId: 8, tagName: "정치"),
    ]
#endif
}

