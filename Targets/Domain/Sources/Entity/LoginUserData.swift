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
            return LoginUserData(nickName: "", accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwiaWF0IjoxNjczMjcxOTE3LCJleHAiOjExNjczMjcxOTE3LCJzdWIiOiJBQ0NFU1NfVE9LRU4ifQ.6OOgMuOsvkaNK_fC5zNFIP3NhhhfDgZheAeVHXM0Wtk", userId: 8, mail: "")
//            guard let value = UserDefaults.standard.value(forKey: "LoginUser") else { return nil }
//            guard let data = value as? Data else { return nil }
//            let loginUser = try? JSONDecoder().decode(LoginUserData.self, from: data)
//            return loginUser
        }
        set {
            let jsonData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(jsonData, forKey: "LoginUser")
        }
    }
    
    let nickName: String
    let accessToken: String
    let userId: Int
    let mail: String
}
