//
//  BookmarkModel.swift
//  Domain
//
//  Created by cheonsong on 2022/09/22.
//

import Foundation
import RealmSwift

public struct Bookmark {

    public var id: Int
    public var mood: Mood
    public var weather: Weather
    public var date: String
    public var location: Location
    public var hasWritten: Bool
    
    public init(id: Int, mood: Mood, weather: Weather, date: String, location: Location, hasWritten: Bool) {
        self.id = id
        self.mood = mood
        self.weather = weather
        self.date = date
        self.location = location
        self.hasWritten = hasWritten
    }
}

public struct BookmarkList {
    var bookmarks: [Bookmark]
    
    public init(bookmarks: [Bookmark]) {
        self.bookmarks = bookmarks
    }
}


public struct Mood {
    public enum MoodCase: String {
        case mood1
        case mood2
        case mood3
        case mood4
        case mood5
    }
    
    public var mood: MoodCase
    
    public init(mood: MoodCase) {
        self.mood = mood
    }
}

public struct Location {
    public var lat: Double
    public var lon: Double
    
    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
