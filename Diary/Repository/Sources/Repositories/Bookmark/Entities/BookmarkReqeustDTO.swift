//
//  BookmarkReqeustDTO.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation

struct BookmarkRequestDTO {
    var id: Int
    var weather: String
    var location: LocationDTO
    var date: String
    var mood: String
    var hasWritten: Bool
    
    init(id: Int, weather: String, location: LocationDTO, date: String, mood: String, hasWritten: Bool) {
        self.id = id
        self.weather = weather
        self.location = location
        self.date = date
        self.mood = mood
        self.hasWritten = hasWritten
    }
}
