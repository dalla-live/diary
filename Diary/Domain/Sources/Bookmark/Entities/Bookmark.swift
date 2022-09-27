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
    public enum MoodCase: Int, CaseIterable {
        case happy        // 행복한
        case sad          // 슬픈
        case angry        // 화난
        case amazed       // 놀라운
        case shameful     // 부끄러운
        
        public var text: String {
            switch self {
            case .happy: return "행복한"
            case .sad: return "슬픈"
            case .angry: return "화난"
            case .amazed: return "놀라운"
            case .shameful: return "부끄러운"
            }
        }
        
        public var emoticon: String {
            switch self {
            case .happy: return "😀"
            case .sad: return "😢"
            case .angry: return "😡"
            case .amazed: return "🤩"
            case .shameful: return "☺️"
            }
        }
    }
    public var mood: MoodCase
    
    public init(mood: MoodCase) {
        self.mood = mood
    }
}

public struct Location {
    public var lat: Double
    public var lon: Double
    public var address: String
    
    public init(lat: Double, lon: Double, address: String) {
        self.lat = lat
        self.lon = lon
        self.address = address
    }
}
