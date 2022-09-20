//
//  DateInfo.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/13.
//

import Foundation

struct DateInfo {
    var date : Date
    var dayInMonth : Int {
        CalendarHelper.shared.getDayInMonth(date)
    }
    
    var firstDayOfMonth : Date {
        CalendarHelper.shared.getFirstOfMonth(date)
    }
    
    var startingSpaces : Int {
        CalendarHelper.shared.getWeekDay(firstDayOfMonth)
    }
    
    var prevMonth : Date {
        CalendarHelper.shared.getFirstOfMonth(date)
    }
    
    var daysInprevMonth : Int {
        CalendarHelper.shared.getDayInMonth(prevMonth)
    }
    
    var getDate : String {
        CalendarHelper.shared.getDate(date)
    }
    
    init(date: Date) {
        self.date = date
    }
}
