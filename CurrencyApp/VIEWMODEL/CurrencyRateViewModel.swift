//
//  CurrencyRateViewModel.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class CurrencyRateViewModel {
    private let networkManager: NetworkManager
    var completion: (([String: CurrencyRate]) -> Void)?
    private (set) var currentData: [String: CurrencyRate] = [:] {
        didSet {
            guard !currentData.isEmpty else { return }
            completion?(currentData)
        }
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getCurrecyRates(currency: CurrencyType) {
        let endpoint = CurrencyEndpoints.getCurrentRate(currency: currency)
        networkManager.makeRequest(endpoint: endpoint) { (result: Result<CurrencyRateResponse>) in
            switch result {
            case .failure(let errorMessage):
                print(errorMessage)
            case .success(let currencyRateResponse):
                self.currentData = currencyRateResponse.bpi
            }
        }
    }
}
