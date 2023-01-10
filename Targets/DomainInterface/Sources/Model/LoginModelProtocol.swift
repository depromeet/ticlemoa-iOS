//
//  LoginModelProtocol.swift
//  Domain
//
//  Created by 김용우 on 2023/01/03.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public protocol LoginModelProtocol {
    var userDataPublisher: Published<LoginUser?>.Publisher { get }
    func checkKakaoLogin() async -> Bool
    func isKakaoTalkLoginUrl(_ url: URL) -> Bool
    func authController(url: URL) -> Bool
    func requestAccessToken() async -> Bool
    func nicknameChangeTo(_ nickname: String)
}
