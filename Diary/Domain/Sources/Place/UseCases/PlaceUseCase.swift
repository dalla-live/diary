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

public enum PlaceUseCaseRequestWrapper {
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


public protocol PlaceUseCase : SearchPlaceUseCase,  AddPlaceUseCase, UpdatePlaceUseCase, DeletePlaceUseCase, GetPlaceUseCase{

}

public class PlaceUseCaseProvider: PlaceUseCase {
    
    private let placeRepository: PlaceRepositoryProtocol!
    
    public init(placeRepo: PlaceRepositoryProtocol) {
        self.placeRepository = placeRepo
    }
    
    func excute(completion: @escaping (BookmarkList) -> Void) {
        
    }
    
    public func search(requestVo: SearchPlaceReqValue, completion: @escaping (Result<BookmarkList, Error>) -> Void) {
        switch requestVo.type {
        case .all:
            self.placeRepository.fetchBookmarkList(query: requestVo.type, page: 0) { list in
                completion(.success(list))
            }
        case .month(_):
            print("mon")
        case .id(_):
            print("id")
        case .location(_, _):
            print("lo")
        }
    }
    
    public func add(requestVo: SearchPlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void) {
        
    }
    
    public func update(requestVo: AddUpdatePlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void) {
        
    }
    
    public func delete(requestVo: DeletePlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void) {
        
    }
    
    public func reqNaverMapAddress(location : Location, completion: @escaping (Result<String, Error>) -> Void) {
        placeRepository.requestAddress(request: location, completion: { result in
            print("result")
        })
    }
}

