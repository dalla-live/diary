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
    public var note: String
    
    public init(id: Int, mood: Mood, weather: Weather, date: String, location: Location, hasWritten: Bool, note: String) {
        self.id         = id
        self.mood       = mood
        self.weather    = weather
        self.date       = date
        self.location   = location
        self.hasWritten = hasWritten
        self.note       = note
    }
    public init() {
        self.id = 0
        self.mood = .init(mood: .angry)
        self.weather = .init(weather: .clear)
        self.date = ""
        self.location = .init(lat: 0, lon: 0)
        self.hasWritten = false
        self.note = ""
    }
}

public struct BookmarkList {
    public var bookmarks: [Bookmark]
    public var hasNext: Bool
    public init(bookmarks: [Bookmark], hasNext: Bool) {
        self.bookmarks = bookmarks
        self.hasNext = hasNext
    }
    
    public init() {
        self.bookmarks = []
        self.hasNext = false
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
    
    public init(string mood: String) {
        var moodCase: MoodCase {
            switch mood {
            case Mood.MoodCase.happy.text: return .happy
            case Mood.MoodCase.sad.text: return .sad
            case Mood.MoodCase.angry.text: return .angry
            case Mood.MoodCase.amazed.text: return .amazed
            case Mood.MoodCase.shameful.text: return .shameful
            default: return .happy
            }
        }
        self.mood = moodCase
    }
}

public struct Location {
    public var lat: Double
    public var lon: Double
    public var address: String
    
    public init(lat: Double, lon: Double, address: String) {
        self.lat     = lat
        self.lon     = lon
        self.address = address
    }
    
    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
        self.address = ""
    }
}
