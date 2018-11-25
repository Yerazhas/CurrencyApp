//
//  BitcointRateViewModel.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

typealias BPI = [String: Double]

class BitcointRateViewModel {
    private let networkManager: NetworkManager
    var completion: ((BPI) -> Void)?
    private var currencyData: BPI = [:] {
        didSet {
            guard !currencyData.isEmpty else { return }
            completion?(currencyData)
        }
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getCurrencyData(currencyType: CurrencyType, date: DateElementType) {
        let endpoint = CurrencyEndpoints.getHistoricalData(currency: currencyType, date: date)
        networkManager.makeRequest(endpoint: endpoint) { (result: Result<CurrencyData>) in
            switch result {
            case .failure(let errorMessage):
                print(errorMessage)
                self.currencyData = [:]
            case .success(let currencyData):
                self.currencyData = currencyData.bpi
                print(currencyData.bpi)
            }
        }
    }
}
