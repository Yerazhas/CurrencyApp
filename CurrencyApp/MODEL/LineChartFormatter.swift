//
//  LineChartFormatter.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/25/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Charts

class LineChartFormatter: IAxisValueFormatter {
    var values: [String] = []
    
    init(values: [String]) {
        self.values = values
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return Int(value) < values.count ? values[Int(value)] : "?"
    }
}
