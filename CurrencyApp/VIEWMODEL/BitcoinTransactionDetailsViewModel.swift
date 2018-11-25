//
//  BitcoinTransactionDetailsViewModel.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/26/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class BitcoinTransactionDetailsViewModel {
    let transaction: TransactionViewModel
    var completion: ((TransactionViewModel) -> Void)?
    
    init(transaction: TransactionViewModel) {
        self.transaction = transaction
    }
    
    func getData() {
        completion?(transaction)
    }
}
