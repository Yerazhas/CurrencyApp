//
//  TimePeriod.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/25/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

enum TimePeriod {
    case week
    case month
    case year
    
    var name: String {
        switch self {
        case  .week: return "Week"
        case .month: return "Month"
        case  .year: return "Year"
        }
    }
}
