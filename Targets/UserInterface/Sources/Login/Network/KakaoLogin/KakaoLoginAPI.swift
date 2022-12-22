//
//  KakaoLoginAPI.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/21.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation


class LoginAPI {

    func kakaoLogin(body: KakaoLoginRequest) async throws -> KakaoLoginResponse? {
        let request = try Router.kakaoLogin(body: body).request()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        print("DEBUG: ", httpResponse!)
        guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 201 else {
            throw "로그인 API Error"
        }
        print("DEUBG: \(response.description)")
        return try JSONDecoder().decode(KakaoLoginResponse.self, from: data)
    }
}
