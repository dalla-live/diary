//
//  MonthStruct.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/13.
//

import Foundation


enum MonthType {
    case Prev
    case Curr
    case Next
}

struct MonthStruct {
    var monthType: MonthType
    var dayInt : Int = 0
    var date : Date? = nil
    
    func day() -> String {
        return String(dayInt)
    }

    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        guard let data = date else { return "" }
        return "\(dateFormatter.string(from: data)).\(dayInt)"
    }
}
