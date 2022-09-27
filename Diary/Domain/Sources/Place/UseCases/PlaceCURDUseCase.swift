//
//  File3.swift
//  Domain
//
//  Created by inforex_imac on 2022/09/22.
//

import Foundation

//    case add(entity: PlaceEntity)
//    case update(entity: PlaceEntity)
//    case deleteBy(id: String)
//    case select(isAll: Bool , page: String)
//    case selectBy(id: String)
//    case searchBy(placeName: String)

public struct SearchPlaceReqValue {
    enum SearchPlace {
        case list
        case byId(id: String)
        case byPlace(name: String)
    }
    let type: SearchPlace
}

// 장소 검색
public protocol SearchPlaceUseCase {
    func search(requestVo: SearchPlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void)
}


public struct AddUpdatePlaceReqValue {
    let place : PlaceEntity
}

// 장소 추가
public protocol AddPlaceUseCase {
    func add(requestVo: AddUpdatePlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void)
//    func add(entity : PlaceEntity)
}

// 장소 수정
public protocol UpdatePlaceUseCase {
    func update(requestVo: AddUpdatePlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void)
//    func update(entity : PlaceEntity)
}

public struct DeletePlaceReqValue {
    let id: String
}
// 장소 제거
public protocol DeletePlaceUseCase {
    func delete(requestVo: DeletePlaceReqValue, completion: @escaping (Result<PlacePage, Error>) -> Void)
//    func delete(id: String) -> Bool
}
