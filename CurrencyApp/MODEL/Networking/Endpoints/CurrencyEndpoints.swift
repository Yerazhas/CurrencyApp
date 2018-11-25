//
//  CurrencyEndpoints.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Alamofire

enum CurrencyEndpoints: EndPointType {
    
    case getHistoricalData(currency: CurrencyType, date: DateElementType)
    case getCurrentRate(currency: CurrencyType)
    
    var baseURL: String {
        return "https://api.coindesk.com/v1/bpi/"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var httpTask: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var path: String {
        switch self {
        case let .getHistoricalData(currency, date):
            var mainURL = "historical/close.json?currency=\(currency.name)"
            if case let .date(date) = date {
                if date.startDate == date.endDate {
                    mainURL += "&for=yesterday"
                } else {
                    mainURL += "&start=\(date.startDate)&end=\(date.endDate)"
                }
            }
            
            return mainURL
        case let .getCurrentRate(currency):
            return "currentprice/\(currency.name).json"
        }
    }
}
