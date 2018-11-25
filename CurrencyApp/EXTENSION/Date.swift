//
//  Date.swift
//  CurrencyApp
//
//  Created by Yerassyl Zhassuzakhov on 11/24/18.
//  Copyright © 2018 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

extension Date {
    var calendar: Calendar {
        var gregorianCalendar = Calendar(identifier: .gregorian)
        gregorianCalendar.firstWeekday = 2
        
        return gregorianCalendar
    }
    
    func getString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let formattedString = dateFormatter.string(from: self)
        print(formattedString)
        
        return formattedString
    }
    
    private func getWeekDateElement() -> DateElement {
        var startDate = Date()
        var interval = TimeInterval()
        _ = calendar.dateInterval(of: .weekOfMonth, start: &startDate, interval: &interval, for: Date())
        
        return DateElement(startDate: startDate.getString(), endDate: self.getString())
    }
    
    private func getMonthDateElement() -> DateElement {
        let currentDay = calendar.component(Calendar.Component.day, from: self)
        let startOfMonth = calendar.date(byAdding: .day, value: -currentDay, to: self)!
        
        return DateElement(startDate: startOfMonth.getString(), endDate: self.getString())
    }
    
    private func getYearDateElement() -> DateElement {
        let year = calendar.component(.year, from: self)
        let startOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
        
        return DateElement(startDate: startOfYear.getString(), endDate: self.getString())
    }
    
    func getDateElement(timeInterval: TimePeriod) -> DateElement {
        switch timeInterval {
        case .week:
            return getWeekDateElement()
        case .month:
            return getMonthDateElement()
        case .year:
            return getYearDateElement()
        }
    }
    
}
