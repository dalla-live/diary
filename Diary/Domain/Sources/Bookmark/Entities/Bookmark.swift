//
//  Bookmark.swift
//  DomainTests
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import CoreLocation
import RealmSwift

class Bookmark: Object {
    typealias Identifier = Int
    
    @objc dynamic var id: Identifier = 0
    @objc dynamic var weather: String = ""
    @objc dynamic var location: Location? = Location()
    @objc dynamic var date: Date = Date()
    @objc dynamic var mood: String = ""
    @objc dynamic var hasWritten: Bool = false
    
    let ofDiary = LinkingObjects(fromType: Diary.self, property: "bookmark")
    
    convenience init(id: Identifier, weather: String, location: Location, mood: String, hasWritten: Bool) {
        self.init()
        self.id = id
        self.weather = weather
        self.location = location
        self.mood = mood
        self.hasWritten = hasWritten
    }
    
    
    // 기본키 설정
    override class func primaryKey() -> String? {
        return "id"
    }
}

public class Location: Object {
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    
    public func getLat()-> Double {
        return lat
    }
    
    public func getLon()-> Double {
        return lon
    }
}

struct BookmarkList {
    let bookmarks: [Bookmark]
}
