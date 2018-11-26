//
//  BitcoinTransactionsViewModel.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/25/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class BitcoinTransactionsViewModel {
    private let networkManager: NetworkManager
    var completion: (([Transaction]) -> Void)?
    var currentData: [Transaction] = [] {
        didSet {
            guard !currentData.isEmpty else { return }
            completion?(currentData)
        }
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getTransactions() {
        let endpoint = TransactionEndpoints.transactions()
        networkManager.makeRequest(endpoint: endpoint) { (result: Result<[Transaction]>) in
            switch result {
            case .failure(let errorMessage):
                print(errorMessage)
            case .success(let transactions):
                self.currentData = transactions.count > 500 ? Array(transactions.prefix(500)) : transactions
            }
        }
    }
}
