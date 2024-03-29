//
//  HomeArticleListModel.swift
//  UserInterface
//
//  Created by 김용우 on 2023/01/11.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import SwiftUI
import Combine
import DomainInterface

typealias ArticleGroup = [(String, [Article])]

final class HomeArticleListModel: ObservableObject {
    
    enum FilterType: CustomStringConvertible {
        case newest
        case oldest
        
        var description: String {
            switch self {
                case .newest: return "최신순"
                case .oldest: return "오래된순"
            }
        }
        
        var next: Self {
            switch self {
                case .newest: return .oldest
                case .oldest: return .newest
            }
        }
    }
    
    @ObservedObject var modelContainer: ModelContainer
    @Published var articles: ArticleGroup = [] {
        willSet {
            print(articles)
            objectWillChange.send()
        }
    }
    @Published var filterType: FilterType = .newest {
        willSet {
            NotificationCenter.default.post(name: .filterArticleList, object: nil)
        }
    }
    var cancellableSet: Set<AnyCancellable> = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        
        modelContainer.articleModel.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] articles in
                let filteredArticle: [Article]
                switch self?.filterType {
                    case .newest:
                        filteredArticle = articles.reversed()
                    case .oldest:
                        filteredArticle = articles
                    case .none:
                        filteredArticle = []
                }
                guard let groupedArticles = self?.groupArticlesByMonth(articles: filteredArticle) else {
                    return
                }
                DispatchQueue.main.async {
                    self?.articles = groupedArticles
                }
            })
            .store(in: &cancellableSet)
    }
}


extension HomeArticleListModel {
    
    /// 월별 데이터 정렬 메소드
    func groupArticlesByMonth(articles: [Article]) -> ArticleGroup {
        guard !articles.isEmpty else { return [] }
        
        var sections = [(String, [Article])]()
        articles.forEach({ article in
            if let index = sections.firstIndex(where: { $0.0 == article.month }) {
                sections[index].1.append(article)
            } else {
                sections.append((article.month, [article]))
            }
        })
        
        return sections
    }
    
}

extension Article {
    
    var dateParsed: Date {
        DateFormatter.formatter.date(from: createdAt) ?? Date()
    }
    
    var month: String {
        let year = dateParsed.formatted(.dateTime.year())
        let month = dateParsed.formatted(.dateTime.month(.twoDigits))
        return year + " " + month
    }
    
}
