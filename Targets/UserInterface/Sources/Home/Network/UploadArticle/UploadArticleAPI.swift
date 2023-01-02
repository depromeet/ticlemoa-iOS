//
//  UploadArticleAPI.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/22.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
class UploadArticleAPI {

    func uploadArticle(body: UploadArticleRequest) async throws -> UploadArticleResponse? {
        let request = try Router.upoloadArticle(body: body).request()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        print("DEBUG: ", httpResponse!)
        guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 201 else {
            throw "아키틀 업로드 API Error"
        }
        print("DEUBG: \(response.description)")
        return try JSONDecoder().decode(UploadArticleResponse.self, from: data)
    }
}
