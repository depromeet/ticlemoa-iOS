//
//  TagModel.swift
//  Domain
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

import API
import DomainInterface

extension TagData {
    static var dummy: [Self] {
        [
            "전체", "빨간라인", "넘으면", "내려감", "디자인",
            "MD", "커리어고민", "CS/CX", "인간관계", "개발",
            "마케팅", "서비스기획", "조직문화", "IT/기술", "취업 이직",
            "회사생활", "라이프스타일", "경영/젼략"
        ].enumerated().map({
            .init(id: $0.offset, userId: 1, tagName: $0.element)
        })
    }
}

public final class TagModel: TagModelProtocol {
    
    
    public var itemsPublisher: Published<[Tag]>.Publisher { $items }

    @Published private var items: [Tag] = TagData.dummy
    private let api: APIDetails = TiclemoaAPI()
    
    public init() {
        
    }
    
}

extension TagModel {
    
    public func fetch() {
        
    }
    
    public func create(tagName: String) async throws {
        
        let requestBody = CreateTagRequest.Body(tagName: tagName)
        
        let uploadTagRequest = CreateTagRequest(
            accessToken: "accessToken",
            body: requestBody
        )
        let result = await api.request(by: uploadTagRequest)
        
        do {
            switch result {
            case .success(_):
                print("태그 추가 성공")
            case .failure(let error):
               throw error
            }
        } catch {
            throw error
        }
    }
    
    public func read(page: Int, take: Int) async throws {
        let readTagRequest = ReadTagRequest(accessToken: "accessToken", page: page, take: take)
        let result = await api.request(by: readTagRequest)
        
        do {
            switch result {
            case .success(let data):
                let response = try JSONDecoder().decode(ReadTagResponse.self, from: data)
                self.items = response.tags.map {
                    TagData(
                        id: $0.id,
                        userId: $0.userId,
                        tagName: $0.tagName)
                }
            case .failure(let error):
               throw error
            }
        } catch {
            throw error
        }
    }
    
    public func update(tagId: Int, tagName: String) async throws {
        let requestBody = UpdateTagRequest.Body(tagName: tagName)
        
        let updateTagRequest = UpdateTagRequest(accessToken: "accessToken", tagId: tagId, body: requestBody)
        let result = await api.request(by: updateTagRequest)
        
        do {
            switch result {
            case .success(_):
                print("태그 업데이트 성공")
            case .failure(let error):
               throw error
            }
        } catch {
            throw error
        }
        
    }
    
    public func remove(tagId: Int) async throws {
        let deleteTagRequest = DeleteTagRequest(accessToken: "accessToken", tagId: tagId)
        let result = await api.request(by: deleteTagRequest)
        
        do {
            switch result {
            case .success(_):
                print("태그 제거 성공")
            case .failure(let error):
               throw error
            }
        } catch {
            throw error
        }
    }
}
