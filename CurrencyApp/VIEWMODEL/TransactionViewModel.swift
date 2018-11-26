//
//  TransactionViewModel.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/26/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

@objcMembers class TransactionViewModel: NSObject {
    let amount: String
    var date: String
    let price: String
    let type: String
    
    init(transaction: Transaction) {
        self.amount = transaction.amount
        self.date = ""
        self.price = "$ \(transaction.price)"
        self.type = transaction.type
        super.init()
        self.date = self.getDateFromUnixTimestamp(transaction.date)
    }
    
    func getDateFromUnixTimestamp(_ timestamp: String) -> String {
        guard let dateDoubleValue = Double(timestamp) else { return  "" }
        let date = Date(timeIntervalSince1970: dateDoubleValue)
        
        return date.getString()
    }
}
