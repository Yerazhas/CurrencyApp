//
//  Transaction.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/25/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class Transaction: Decodable {
    let date: String
    let tid: String
    let price: String
    let type: String
    let amount: String
}
