//
//  CalendarViewModel.swift
//  Presantation
//
//  Created by ejsong on 2022/09/21.
//

import Foundation
import Domain
import RxCocoa
import RxSwift

public struct CalendarViewModelAction {
    let showDiaryVC : (Bookmark) -> Void
}

protocol CalendarInput {
    func getContentofList(date : String)
    func getMonth(month : String)
    func getDate(date : Date)
}

protocol CalendarOutput {
    var monthOfDate : BehaviorRelay<String> { get }
    var monthStruct : BehaviorRelay<[MonthStruct]> { get }
    var contentsList : BehaviorRelay<[Bookmark]> { get }
    var bookmarkList : BehaviorRelay<BookmarkList> { get }
    var dateList : BehaviorRelay<[String]> { get }
}

public class CalendarViewModel : CalendarInput , CalendarOutput {
    
    typealias Dependency = Model
    
    struct Model {
        var date : Date = Date()
        var dateInfo : DateInfo = DateInfo(date: Date())
        var currSelectedDate : String = ""
    }
    
    //Output
    var monthOfDate: BehaviorRelay<String> = .init(value: "")
    var monthStruct: BehaviorRelay<[MonthStruct]> = .init(value: [])
    var contentsList : BehaviorRelay<[Bookmark]> = .init(value: [])
    var bookmarkList: BehaviorRelay<BookmarkList> = .init(value: BookmarkList() )
    var dateList : BehaviorRelay<[String]> = .init(value: [])
    
    var model : Dependency      = .init()
    
    private let usecase : FetchDiaryUseCase
    private let action : CalendarViewModelAction
    
    public init(usecase : FetchDiaryUseCase, action : CalendarViewModelAction) {
        self.usecase = usecase
        self.action = action
    }
    
    func openDiaryViewController(_ bookmark : Bookmark) {
        action.showDiaryVC(bookmark)
    }
    
    func getContentofList(date: String) {
        print("date :: \(date)")
        usecase.getListByDate(date) { [weak self] result in
            guard let self = self else { return }
            self.contentsList.accept(result.bookmarks)
        }
    }
    
    func getMonth(month: String){
        self.bookmarkList.accept(BookmarkList())
        var list : [String] = []
        
        usecase.getListByMonth(month) { [weak self] data in
            guard let self = self else { return }
            data.bookmarks.forEach{ data in
                if !list.contains(data.date) {
                    list.append(data.date)
                }
            }
            self.bookmarkList.accept(data)
        }
        
        self.dateList.accept(list)
    }
    
    func getDate(date: Date) {
        
        model.date = date
        model.dateInfo = DateInfo(date: date)
        monthOfDate.accept(CalendarHelper.shared.monthYear(self.model.date))
        monthList()
    }
    
    func monthList(){
        var monthList : [MonthStruct] = []
        
        (1...42).forEach{ i in
            monthList.append(monthStruct(i))
        }
    
        monthStruct.accept(monthList)
    }
    
    func monthStruct(_ count : Int) -> MonthStruct {
        
        let startSpace = self.model.dateInfo.startingSpaces
        
        if count <= self.model.dateInfo.startingSpaces {
            return MonthStruct(monthType : MonthType.Prev)
            
        }else if count - startSpace > self.model.dateInfo.dayInMonth {
            return MonthStruct(monthType: MonthType.Next)
        }
        
        let day = count - startSpace
        
        return MonthStruct(monthType: MonthType.Curr, dayInt: day, date: model.date)
    }
}
