//
//  ErrorType.swift
//  UserInterface
//
//  Created by 김우성 on 2022/12/18.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

// Error 를 String 으로 편리하게 사용하기 위해 추가
extension String: Error {}

enum ErrorType: LocalizedError {
    case parseUrlFail
    case notFound
    case validationError
    case serverError
    case defaultError
    
    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object."
        case .notFound:
            return "Not Found"
        case .validationError:
            return "Validation Errors"
        case .serverError:
            return "Internal Server Error"
        case .defaultError:
            return "Something went wrong."
        }
    }
}
