//
//  File.swift
//  DomainTests
//
//  Created by inforex_imac on 2022/09/16.
//

import Foundation
import CoreLocation

//
//protocol SearchLocationUseCase {
//    func execute(requestValue: SearchLocationRequestValue, completion: @escaping (Result<Location, Error>) -> Void)
//}
//
//
//class SearchLocationUseCaseProvider: SearchLocationUseCase {
//    func execute(requestValue: SearchLocationRequestValue, completion: @escaping (Result<Location, Error>) -> Void) {
//
//    }
//}


public struct SearchLocationRequestModel {
    
}
public protocol LocationUseCase {
    func execute(model: SearchLocationRequestModel)
}



public class LocationUseCaseProvider : LocationUseCase {

    
    public init() {
    }
    
    public func execute(model: SearchLocationRequestModel) {
        
    }
}
