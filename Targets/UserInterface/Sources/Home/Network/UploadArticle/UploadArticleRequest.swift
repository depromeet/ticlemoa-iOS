//
//  UploadArticleRequest.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/22.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

struct UploadArticleRequest: Encodable {
    let content: String
    let userId: Int = 0 // TODO: 서버 개발 되면, 이부분 변경필요 12.22
    let title: String
    let url: String
    let isPublic: Bool
    let tagIds: [Int]
    
}
