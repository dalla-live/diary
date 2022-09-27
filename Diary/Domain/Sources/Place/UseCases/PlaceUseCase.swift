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
//    func excute(requestModel: MapUseCaseRequestWrapper, completion: @escaping (Result<PlacePage, Error>) -> Void)
}

public class MapUseCaseProvider: PlaceUseCase {
    
    private let placeRepository: PlaceRepository!
    
    func excute(completion: @escaping (BookmarkList) -> Void) {
        
    }
    
    public func search(requestVo: SearchPlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void) {
//        switch requestVo.type {
//        case .byId(id: let idd) :
//
//            break
//        case .list:
//            break
//        case .byPlace(name: let namee ):
//            break
//        }
            
    }
    
    public func add(requestVo: AddUpdatePlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void) {
        
    }
    
    public func update(requestVo: AddUpdatePlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void) {
        
    }
    
    public func delete(requestVo: DeletePlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void) {
        
    }
    
    
    
//    public func excute(requestModel: MapUseCaseRequestWrapper, completion: @escaping (Result<PlacePage, Error>) -> Void) {
//        switch requestModel {
//
//        case .add(entity: let entity):
//            <#code#>
//        case .update(entity: let entity):
//            <#code#>
//        case .deleteBy(id: let id):
//            <#code#>
//        case .select(isAll: let isAll, page: let page):
//            <#code#>
//        case .selectBy(id: let id):
//            <#code#>
//        case .searchBy(placeName: let placeName):
//            <#code#>
//        }
//    }
    
    public init(placeRepo: PlaceRepository) {
        self.placeRepository = placeRepo
    }
}

