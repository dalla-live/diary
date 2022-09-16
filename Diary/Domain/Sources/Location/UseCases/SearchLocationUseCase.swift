//
//  File.swift
//  DomainTests
//
//  Created by inforex_imac on 2022/09/16.
//

import Foundation
import Repository


struct SearchLocationRequestValue {
    
}

protocol SearchLocationUseCase {
    func execute(requestValue: SearchLocationRequestValue, completion: @escaping (Result<Location, Error>) -> Void)
}


class SearchLocationUseCaseProvider: SearchLocationUseCase {
    func execute(requestValue: SearchLocationRequestValue, completion: @escaping (Result<Location, Error>) -> Void) {
        
    }
}
