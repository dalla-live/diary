//
//  CalendarHelper.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/13.
//

import Foundation

struct CalendarHelper {
    static let shared = CalendarHelper()
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthYear(_ curdate : Date) -> String {
        dateFormatter.dateFormat = "yyyy.MM"
        return dateFormatter.string(from: curdate)
    }
    
    func getPrevMonth(_ curdate : Date) -> Date {
        guard let date = calendar.date(byAdding: .month, value: -1, to: curdate) else { return curdate }
        return date
    }
    
    func getNextMonth(_ curdate : Date) -> Date {
        guard let date = calendar.date(byAdding: .month, value: 1, to: curdate) else { return curdate }
        return date
    }
    
    /* 해당 달의 일 수 */
    func getDayInMonth(_ curdate : Date) -> Int {
        guard let date = calendar.range(of: .day, in: .month, for: curdate) else { return 0 }
        return date.count
    }
    
    func getFirstOfMonth(_ curdate : Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: curdate)
        guard let date = calendar.date(from: components) else { return curdate}
        return date
    }
    
    /* 요일 */
    func getWeekDay(_ curdate : Date) -> Int {
        guard let weekday = calendar.dateComponents([.weekday], from: curdate).weekday else { return 0 }
        return weekday - 1
    }
    
    func getDate(_ curdate : Date = Date()) -> String {
        dateFormatter.dateFormat = "yyyy.MM.d"
        return dateFormatter.string(from: curdate)
    }
}
