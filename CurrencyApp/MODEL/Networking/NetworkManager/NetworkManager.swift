//
//  NetworkManager.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Alamofire
import SwiftyJSON

public class NetworkManager {
    let parser: Parser
    
    init(parser: Parser) {
        self.parser = parser
    }
    
    init() {
        self.parser = CustomParser()
    }
    
    func makeRequest<T: Decodable>(endpoint: EndPointType, completion: @escaping (Result<T>) -> Void) {
//        SVProgressHUD.show()
        let urlString = (endpoint.baseURL + endpoint.path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)!
        print(url)
        switch endpoint.httpTask {
        case .request:
            Alamofire.request(url, method: endpoint.httpMethod, encoding: JSONEncoding.default, headers: endpoint.headers).validate(statusCode: 200..<300).responseJSON { (response) in
//                SVProgressHUD.dismiss()
                print(response)
                completion(self.parser.parse(response: response))
            }
            
        case .requestWithParameters(let parameters):
            Alamofire.request(url, method: endpoint.httpMethod, parameters: parameters, headers: endpoint.headers)
                .validate(statusCode: 200..<300).responseJSON { (response) in
//                    SVProgressHUD.dismiss()
                    completion(self.parser.parse(response: response))
            }
            
        case let .requestWithMultipartData(data, parameters, parameterName):
            Alamofire.upload(multipartFormData: { (multipartData) in
                for (key, value) in parameters {
                    if value is [String] {
                        for newValue in value as! [String] {
                            multipartData.append((newValue).data(using: .utf8)!, withName: key)
                        }
                    } else if let intArray = value as? [Int] {
                        for newValue in intArray {
                            multipartData.append(("\(newValue)").data(using: .utf8)!, withName: key)
                        }
                    } else if value is String || value is Int {
                        multipartData.append(("\(value)").data(using: .utf8)!, withName: key)
                    }
                }
                if let array = data as? [Data] {
                    for data in array {
                        multipartData.append(data, withName: parameterName, fileName: UUID().uuidString + ".jpg", mimeType: "image/jpg")
                    }
                } else if let data = data as? Data {
                    multipartData.append(data, withName: parameterName, fileName: UUID().uuidString + ".jpg", mimeType: "image/jpg")
                }
            }, usingThreshold: UInt64(), to: url, method: .post, headers: endpoint.headers, encodingCompletion: { (result) in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.validate(statusCode: 200..<300).responseJSON(completionHandler: { (response) in
                        completion(self.parser.parse(response: response))
                    })
                }
            })
        }
    }
}
