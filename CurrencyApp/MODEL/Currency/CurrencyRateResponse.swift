//
//  CurrencyRate.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class CurrencyRateResponse: Decodable {
    private (set) var bpi: [String: CurrencyRate]
}

class CurrencyRate: Decodable {
    var code: String
    var rate: String
    var description: String
    var rateFloat: Double
    
    private enum CodingKeys: String, CodingKey {
        case code
        case rate
        case description
        case rateFloat = "rate_float"
    }
    
    var prettyDescription: String {
        return "Current rate of \(description) to bitcoin: \(rate)"
    }
}
