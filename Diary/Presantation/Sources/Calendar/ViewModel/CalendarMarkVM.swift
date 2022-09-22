//
//  CalendarMarkVM.swift
//  Presantation
//
//  Created by ejsong on 2022/09/19.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

public struct CalendarMarkViewModelAction {
    let showContentsList: (DiaryList) -> Void
}

public class CalendarMarkViewModel {
    struct Model {
        
    }
    
    struct Input {
        let date : Observable<String>?
    }
    
    struct Output {
        
    }
    
    var input : Input?
    var disposeBag  = DisposeBag()
    
   init(_ input : Input) {
        self.input   = input
    }
    /*
     input.date?.bind{ [weak self] data in
         guard let self = self else { return }
         self.getList(data)

     }.disposed(by: disposeBag)
     */
    
    func getList(_ date : String) {
//        usecase.getListByDate(date, completion: {_ in
//
//        })
    }
     
}
