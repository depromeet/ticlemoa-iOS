//
//  LoginUser.swift
//  DomainInterface
//
//  Created by 김용우 on 2023/01/04.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public protocol LoginUser {
    var nickName: String { get }
    var accessToken: String? { get }
    var userId: Int? { get }
    var mail: String { get }
}
