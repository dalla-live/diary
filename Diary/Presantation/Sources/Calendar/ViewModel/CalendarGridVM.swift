//
//  CalendarGridVM.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/13.
//

import Foundation
import RxSwift
import RxCocoa

class CalendarGridViewModel {

    typealias Dependency = Model
    
    struct Model {
        var date : Date = Date()
        var dateInfo : DateInfo = DateInfo(date: Date())
        var hasBooKMarkDate : [String] = ["2022.09.15", "2022.09.22", "2022.09.23"]
        var currSelectedDate : String = ""
    }
    
    struct Input {
        var date : Observable<Date>?
    }
    
    struct Output {
        var monthOfDate : BehaviorRelay<String> = .init(value: "")
        var monthStruct : BehaviorRelay<[MonthStruct]> = .init(value: [])
    }
    
    var model : Dependency      = .init()
    var input : Input?          = Input()
    var output : Output?        = Output()
    var disposeBag : DisposeBag = DisposeBag()
    
    init(_ input: Input) {
        self.input = input
        
        input.date?.bind{ [weak self] date in
            guard let self = self else { return }
            self.model.date = date
            self.model.dateInfo = DateInfo(date: date)
            self.output?.monthOfDate.accept(CalendarHelper.shared.monthYear(self.model.date))
            self.monthList()
        }.disposed(by: disposeBag)

    }
    
    func monthList(){
        var monthList : [MonthStruct] = []
        
        (1...42).forEach{ i in
            monthList.append(monthStruct(i))
        }
    
        self.output?.monthStruct.accept(monthList)
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
