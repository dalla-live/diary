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

public enum MapUseCaseRequestWrapper {
    case add(entity: PlaceEntity)
    case update(entity: PlaceEntity)
    case deleteBy(id: String)
    case select(isAll: Bool , page: String)
    case selectBy(id: String)
    case searchBy(placeName: String)
}

public struct SearchPlaceRequestModel {
    var place: String
    var limit: Int = 1
}

public protocol PlaceUseCase : SearchPlaceUseCase,  AddPlaceUseCase, UpdatePlaceUseCase, DeletePlaceUseCase{

}

public class MapUseCaseProvider: PlaceUseCase {
    public func search(requestModel: MapUseCaseRequestWrapper) {
        
    }
    
    public func add(requestModel: MapUseCaseRequestWrapper) {
        
    }
    
    public func update(requestModel: MapUseCaseRequestWrapper) {
        
    }
    
    public func delete(requestModel: MapUseCaseRequestWrapper) {
        
    }
    
    
    
//    var repository: PlaceRepository!
    
    
    
    
    
    
    
    
    
    
    
//
//    public func excute(requestModel: SearchPlaceRequestModel) {
////        switch requestModel.type {
////        case .add(let bookMark):
////            print("add")
////        case .update(let bookMark):
////            print("update")
////        case .delete(let uuid):
////            print("delete")
////        case .select(let uuid):
////            // all list
////            if uuid == nil {
////
////            } else {
////                // select Row
////
////
////            }
////        }
//    }
//
//    public func execute(model: SearchLocationRequestModel) {
//
//    }
    
    public init() {
    }
}

