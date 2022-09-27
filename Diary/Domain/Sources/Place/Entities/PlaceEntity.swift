//
//  MapModel.swift
//  Domain
//
//  Created by inforex_imac on 2022/09/18.
//


import Foundation
import CoreLocation


// entity , 좌표Vo, 장소이름Vo
public struct PlaceEntity {
    var id : String
    var placeName : String
    var address : Address
    var location : Location // 위치
    
    // 위치를 수정한다면 장소 이름과, 주소도 변경되겠지..
    func changeLocation(location: Location, place: String, address: Address) -> Self {
        return PlaceEntity(
            id: self.id,
            placeName: place,
            address: address,
            location: location
        )
    }
}

//public struct Location {
//    public var lat: Double
//    public var lon: Double
//    
//    public init(lat: Double, lon: Double) {
//        self.lat = lat
//        self.lon = lon
//    }
//}

// 주소가 좌표 참조할 수 있겠지만 좌표가 곡 주소의 속성은 아니므로 일단 좌표모델을는 분리 한다
struct Address {
    var contry: String
    var city: String
    var address: String
}

// 플레이스 페이지
public struct PlacePage {
    let page : Int
    let totalPages: Int
    let places: [PlaceEntity]
}


