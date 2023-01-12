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

public final class TagModel: TagModelProtocol {
    
    public var itemsPublisher: Published<[Tag]>.Publisher { $items }

    @Published private var items: [Tag] = []
    private let api: APIDetails = TiclemoaAPI()
    
    public init() {
        
    }
    
}

extension TagModel {
    
    public func create(tagName: String) async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        
        let requestBody = CreateTagRequest.Body(tagName: tagName)
        
        let uploadTagRequest = CreateTagRequest(
            accessToken: currentUser.accessToken,
            body: requestBody
        )
        
        let result = await api.request(by: uploadTagRequest)
        
        switch result {
        case .success(_):
            print("태그 추가 성공")
            try await self.read()
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
    

    public func read() async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        
        let readTagRequest = ReadTagRequest(accessToken: currentUser.accessToken)

        let result = await api.request(by: readTagRequest)
        
        switch result {
        case .success(let data):
            let response = try JSONDecoder().decode(ReadTagResponse.self, from: data)
                self.items = response.tags.map {
                    TagData(
                        id: $0.id,
                        userId: $0.userId,
                        tagName: $0.tagName)
            }
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
    
    public func update(tagId: Int, tagName: String) async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        
        let requestBody = UpdateTagRequest.Body(tagName: tagName)
        
        let updateTagRequest = UpdateTagRequest(accessToken: currentUser.accessToken, tagId: tagId, body: requestBody)
        let result = await api.request(by: updateTagRequest)
        
        switch result {
        case .success(_):
            print("태그 업데이트 성공")
            try await self.read()
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
    
    public func remove(tagId: Int) async throws {
        guard let currentUser = LoginUserData.shared else { // MARK: 에러처리 필요
            return
        }
        
        let deleteTagRequest = DeleteTagRequest(accessToken: currentUser.accessToken, tagId: tagId)
        let result = await api.request(by: deleteTagRequest)
        
        switch result {
        case .success(_):
            print("태그 제거 성공")
            try await self.read()
        case .failure(let networkError):
            throw DomainInterfaceError.networkError(code: networkError.code)
        }
    }
}
