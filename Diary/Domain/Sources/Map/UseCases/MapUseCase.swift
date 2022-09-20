//
//  MapUseCase.swift
//  Domain
//
//  Created by inforex_imac on 2022/09/18.
//

import Foundation
import CoreLocation
//import Service
import UIKit


public struct SearchPlaceRequestModel {
    
}

public protocol SearchPlaceUseCase {
    func excute(requestModel: SearchPlaceRequestModel)
}

public protocol MapUseCase : SearchPlaceUseCase, LocationUseCase {
    
}
public class MapUseCaseProvider: MapUseCase {
    
    public func excute(requestModel: SearchPlaceRequestModel) {
        
    }
    
    public func execute(model: SearchLocationRequestModel) {
        
    }
    
    public init() {
    }
}
