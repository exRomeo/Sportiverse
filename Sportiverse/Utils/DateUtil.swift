//
//  DateUril.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 29/05/2023.
//

import Foundation

class DateUtil {
    func getTimeRange() -> (startDate:String, endDate:String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let endDate = Calendar.current.date(byAdding: .month, value: 6, to:  Date())!
        let startDateString = dateFormatter.string(from:  Date())
        let endDateString = dateFormatter.string(from: endDate)
        return (startDateString, endDateString)
    }
    
}
