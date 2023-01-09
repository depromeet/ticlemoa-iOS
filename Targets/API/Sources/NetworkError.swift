//
//  NetworkError.swift
//  API
//
//  Created by 김용우 on 2022/12/16.
//  Copyright © 2022 nyongnyong. All rights reserved.
//

import Foundation

public enum NetworkError: Error, CustomStringConvertible {
    case inValidURLString
    case notFound
    case validationError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknownError
    
    public var description: String {
        switch self {
            case .inValidURLString:             return "inValidURLString"
            case .notFound:                     return "Not Found"
            case .validationError:              return "Validation Errors"
            case .serverError:                  return "Internal Server Error"
            case .unknownError:                 return "Something went wrong."
        }
    }
    
    public var code: Int {
        switch self {
        case .inValidURLString:
            return 2001
        case .notFound:
            return 2002
        case .validationError(statusCode: let statusCode):
            return statusCode
        case .serverError(statusCode: let statusCode):
            return statusCode
        case .unknownError:
            return 2003
        }
    }
}
