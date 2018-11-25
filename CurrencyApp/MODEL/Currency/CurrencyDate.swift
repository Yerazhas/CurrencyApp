//
//  Date.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/25/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation


struct DateElement {
    let startDate: String
    let endDate: String
}

enum DateElementType {
    case noDate
    case date(DateElement)
}

enum Week: String {
    case Monday = "1"
    case Tuesday = "2"
    case Wednesday = "3"
    case Thursday = "4"
    case Friday = "5"
    case Saturday = "6"
    case Sunday = "7"
    
    var name: String {
        var result = ""
        switch self {
        case .Monday:
            result = "Mon"
        case .Tuesday:
            result = "Tue"
        case .Wednesday:
            result = "Wed"
        case .Thursday:
            result = "Thu"
        case .Friday:
            result = "Fri"
        case .Saturday:
            result = "Sat"
        case .Sunday:
            result = "Sun"
        }
        
        return result
    }
}

enum Year: String {
    case January = "1"
    case February = "2"
    case March = "3"
    case April = "4"
    case May = "5"
    case June = "6"
    case July = "7"
    case August = "8"
    case September = "9"
    case October = "10"
    case November = "11"
    case December = "12"
    
    var name: String {
        var result = ""
        switch self {
        case .January:
            result = "Jan"
        case .February:
            result = "Feb"
        case .March:
            result = "Mar"
        case .April:
            result = "Apr"
        case .May:
            result = "May"
        case .June:
            result = "Jun"
        case .July:
            result = "Jul"
        case .August:
            result = "Aug"
        case .September:
            result = "Sep"
        case .October:
            result = "Oct"
        case .November:
            result = "Nov"
        case .December:
            result = "Dec"
        }
        
        return result
    }
}
