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
    let showDiaryVC : () -> Void
}

protocol CalendarInput {
    func getContentofList(date : String)
    func getMonth(month : String)
}

protocol CalendarOutput {
    var contentsList : PublishRelay<DiaryList> { get }
    var dateList : BehaviorRelay<[String]> { get }
}

public class CalendarViewModel : CalendarInput , CalendarOutput {
    
    var contentsList : PublishRelay<DiaryList> = .init()
    var dateList: BehaviorRelay<[String]> = .init(value: [])
    
    private let usecase : FetchDiaryUseCase
    private let action : CalendarViewModelAction
    
    public init(usecase : FetchDiaryUseCase, action : CalendarViewModelAction) {
        self.usecase = usecase
        self.action = action
    }
    
    func openDiaryViewController() {
        action.showDiaryVC()
    }
    
    func getContentofList(date: String) {
        print("date :: \(date)")
        usecase.getListByDate(date) { [weak self] data in
            guard let self = self else { return }
            
            do {
                try self.contentsList.accept(data.get())
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getMonth(month: String) {
        print("month :: \(month)")
        usecase.getListByMonth(month) { [weak self] data in
            guard let self = self else { return }
            self.dateList.accept(data)
//            do {
//                try self.dateList.accept(data.get())
//            }catch {
//                print(error.localizedDescription)
//            }
            
        }
    }
}
