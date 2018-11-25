//
//  CustomError.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case informationalError
    case redirectionError
    case notFoundError
    case serverError
    case unknownError
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .informationalError:
            return "Informational error"
        case .redirectionError:
            return "Redirected"
        case .notFoundError:
            return "Not found"
        case .serverError:
            return "Internal server error"
        default:
            return "Unknown error"
        }
    }
}
