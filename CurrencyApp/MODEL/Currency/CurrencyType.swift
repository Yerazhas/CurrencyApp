//
//  CurrencyType.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/25/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

enum CurrencyType {
    case usd
    case eur
    case kzt
    
    var name: String {
        switch self {
        case .usd: return "USD"
        case .eur: return "EUR"
        case .kzt: return "KZT"
        }
    }
}
