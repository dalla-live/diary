//
//  MapModel.swift
//  Domain
//
//  Created by inforex_imac on 2022/09/18.
//


import Foundation


// 테이블을 하나만 쓰므로 북마크 Entity가 전달되면 해당 모델 및 엔티티로 변환 가능하다
struct MapEntity {
    var id : String
    var placeInfo : MapModel
}

struct MapModel {
    var name : String
    var address: Address?  // 주소
}

// MapEntity의 MapModel과 Location의 Position을 합쳐 하나의 장소를 나타내는 애그리거트를 만들었다
struct PlaceAggregate {
    var id : String
    var place: MapModel
    var location : Position // 위치
    
    // 위치를 수정하면 이름과, 주소도 변경되겠지..
    func changeLocation(location: Position, place: MapModel) -> PlaceAggregate {
        return PlaceAggregate(
            id: self.id,
            place: place,
            location: location
        )
    }
}

struct Address {
    var contry: String
    var city: String
    var address: String
}


