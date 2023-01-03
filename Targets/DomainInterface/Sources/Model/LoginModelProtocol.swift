//
//  LoginModelProtocol.swift
//  Domain
//
//  Created by 김용우 on 2023/01/03.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public protocol LoginModelProtocol {
    var userDataPublisher: Published<LoginUser>.Publisher { get }
    func requestKakaoLogin(_ accessToken: String) async -> Bool
}
