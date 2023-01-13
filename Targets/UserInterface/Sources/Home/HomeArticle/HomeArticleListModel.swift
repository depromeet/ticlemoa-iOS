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
    @Published var articles: ArticleGroup = []
    @Published var filterType: FilterType = .newest {
        willSet {
            
        }
    }
    var cancellableSet: Set<AnyCancellable> = []
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        
        modelContainer.articleModel.itemsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] articles in
                guard let groupedArticles = self?.groupArticlesByMonth(articles: articles) else {
                    return
                }
                switch self?.filterType {
                    case .newest:
                        self?.articles = groupedArticles
                    case .oldest:
                        let reversed: ArticleGroup = groupedArticles.reversed()
                        self?.articles = reversed.map({ array in
                            let temp: [Article] = array.1.reversed()
                            return (array.0, temp)
                        })
                    case .none:
                        break
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
        return createdAt.dateParsed()
    }
    
    var month: String {
        let year = dateParsed.formatted(.dateTime.year())
        let month = dateParsed.formatted(.dateTime.month(.twoDigits))
        return year + "." + month
    }
    
}
