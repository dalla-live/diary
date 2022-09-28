//
//  BookmarkReqeustDTO.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation

public struct BookmarkDTO {
    var id: Int
    var weather: String
    var location: LocationDTO
    var date: String
    var mood: String
    var hasWritten: Bool
    var note: String
    
    init(id: Int, weather: String, location: LocationDTO, date: String, mood: String, hasWritten: Bool, note: String) {
        self.id = id
        self.weather = weather
        self.location = location
        self.date = date
        self.mood = mood
        self.hasWritten = hasWritten
        self.note = note
    }
}
