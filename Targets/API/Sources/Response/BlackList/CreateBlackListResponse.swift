//
//  CreateBlackListResponse.swift
//  API
//
//  Created by 김용우 on 2023/01/06.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public struct CreateBlackListResponse: Decodable {
    let userId: Int
    let targetId: Int
}
