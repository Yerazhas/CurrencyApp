//
//  EndpointType.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Alamofire

protocol EndPointType {
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
    var httpTask: HTTPTask { get }
    var headers: HTTPHeaders { get }
    var path: String { get }
}

enum HTTPTask {
    case request
    case requestWithParameters(parameters: Parameters)
    case requestWithMultipartData(data: Any, parameters: Parameters, dataParameterName: String)
}

enum Result<T> {
    case success(T)
    case failure(String)
}

