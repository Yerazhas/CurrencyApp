//
//  TransactionEndpoint.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Alamofire

enum TransactionEndpoints: EndPointType {
    
    case transactions()
    
    var baseURL: String {
        return "https://www.bitstamp.net/api/v2/"
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
        return "transactions/btcusd/"
    }
}
