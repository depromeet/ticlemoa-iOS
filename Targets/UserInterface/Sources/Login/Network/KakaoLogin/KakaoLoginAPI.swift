//
//  KakaoLoginAPI.swift
//  Ticlemoa
//
//  Created by 김우성 on 2022/12/21.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation
// Error 를 String 으로 편리하게 사용하기 위해 추가
extension String: Error {}

class LoginAPI {

    func kakaoLogin() async throws -> KakaoLoginResponse? {
        let body = KakaoLoginRequest(accessToken: "5KE8rCqmO4rAMHkOMHjCYOioEGx5JGOMnJtJoZmmCinJXwAAAYU0ODxM", vendor: "kakao")
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
