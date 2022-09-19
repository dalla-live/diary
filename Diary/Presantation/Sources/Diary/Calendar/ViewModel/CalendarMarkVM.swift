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

class CalendarMarkViewModel {
    struct Model {
        
    }
    
    struct Input {
        let date : Observable<String>?
    }
    
    struct Output {
        
    }
    
    private let fetchDiaryUseCase : FetchDiaryUseCase
    
    var input : Input?
    var disposeBag  = DisposeBag()
    
    init(_ input : Input, fetchDiaryUseCase : FetchDiaryUseCase ) {
        self.input             = input
        self.fetchDiaryUseCase = fetchDiaryUseCase
        
        input.date?.bind{ [weak self] data in
            guard let self = self else { return }
            self.getList(data)

        }.disposed(by: disposeBag)
       
    }
    
    func getList(_ date : String) {
        fetchDiaryUseCase.getListByDate(date, completion: {_ in
            
        })
    }
     
}
