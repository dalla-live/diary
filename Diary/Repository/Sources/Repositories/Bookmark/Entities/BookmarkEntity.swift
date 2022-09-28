//
//  Bookmark.swift
//  DomainTests
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import CoreLocation
import RealmSwift

public class BookmarkEntity: Object {
    typealias Identifier = Int
    
    @objc dynamic var id: Identifier = 0
    @objc dynamic var weather: String = ""
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    @objc dynamic var address: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var mood: String = ""
    @objc dynamic var hasWritten: Bool = false
    @objc dynamic var note: String = ""
    
    convenience init(id: Identifier, weather: String, lat: Double, lon: Double, address: String, date: String, mood: String, hasWritten: Bool, note: String) {
        self.init()
        self.id = id
        self.weather = weather
        self.lat = lat
        self.lon = lon
        self.address = address
        self.date = date
        self.mood = mood
        self.hasWritten = hasWritten
        self.note = note
    }
    
    // 기본키 설정
    public override class func primaryKey() -> String? {
        return "id"
    }
}
