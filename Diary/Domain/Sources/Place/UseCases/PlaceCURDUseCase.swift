//
//  File3.swift
//  Domain
//
//  Created by inforex_imac on 2022/09/22.
//

import Foundation

// 장소 검색
public protocol SearchPlaceUseCase {
    func search(requestModel: MapUseCaseRequestWrapper)
//    func search(place: String)
//    func search(id: String)
//    func search()
}

// 장소 추가
public protocol AddPlaceUseCase {
    func add(requestModel: MapUseCaseRequestWrapper)
//    func add(entity : PlaceEntity)
}

// 장소 수정
public protocol UpdatePlaceUseCase {
    func update(requestModel: MapUseCaseRequestWrapper)
//    func update(entity : PlaceEntity)
}

// 장소 제거
public protocol DeletePlaceUseCase {
    func delete(requestModel: MapUseCaseRequestWrapper)
//    func delete(id: String) -> Bool
}
