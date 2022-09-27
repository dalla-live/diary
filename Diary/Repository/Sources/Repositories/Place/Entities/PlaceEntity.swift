//
//  PlaceEntity.swift
//  Repository
//
//  Created by John Park on 2022/09/25.
//

import Foundation
import CoreLocation
import RealmSwift

public class PlaceEntity: Object {
    typealias Identifier = Int
    
    @objc dynamic var id: Identifier = 0
    @objc dynamic var weather: String = ""
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    @objc dynamic var date: String = ""
    @objc dynamic var mood: String = ""
    @objc dynamic var hasWritten: Bool = false
    
    convenience init(id: Identifier, weather: String, lat: Double, lon: Double, date: String, mood: String, hasWritten: Bool) {
        self.init()
        self.id = id
        self.weather = weather
        self.lat = lat
        self.lon = lon
        self.date = date
        self.mood = mood
        self.hasWritten = hasWritten
    }
    
    // 기본키 설정
    public override class func primaryKey() -> String? {
        return "id"
    }
}
