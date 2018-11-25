//
//  CurrencyData.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

class CurrencyData: Decodable {
    private (set) var bpi: BPI
//    init() {
//        self.bpi = [:]
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case bpi
//    }
//
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.bpi = try values.decode(BPI.self, forKey: .bpi)
//    }
}
