//
//  URLRequestMakable.swift
//  API
//
//  Created by 김용우 on 2023/01/04.
//  Copyright © 2023 nyongnyong. All rights reserved.
//

import Foundation

public protocol URLRequestMakable {
    func makeURLRequest(by baseURL: URL) -> URLRequest
}
