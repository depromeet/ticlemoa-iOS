//
//  LoginUserData.swift
//  Domain
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import DomainInterface
import Foundation

struct LoginUserData: Codable, LoginUser {
    
    static var shared: LoginUserData? {
        get {

            guard let value = UserDefaults.standard.value(forKey: "LoginUser") else { return nil }
            guard let data = value as? Data else { return nil }
            let loginUser = try? JSONDecoder().decode(LoginUserData.self, from: data)
            print("DEBUG: \(loginUser?.userId)")
            print("DEBUG: \(loginUser?.accessToken)")
            return loginUser
        }
        set {
            print("DEBUG: \(newValue)")
            let jsonData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(jsonData, forKey: "LoginUser")
        }
    }
    
    let nickName: String
    let accessToken: String
    let userId: Int
    let mail: String
}
