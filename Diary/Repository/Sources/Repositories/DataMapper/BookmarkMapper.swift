//
//  BookmarkMapper.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation
import Domain

extension BookmarkEntity {
    func toDTO()-> BookmarkResponseDTO {
        return .init(id: id,
                     weather: weather,
                     location: .init(lat: lat, lon: lon),
                     date: date,
                     mood: mood,
                     hasWritten: hasWritten)
    }
}

extension BookmarkResponseDTO {
    func toEntity()-> BookmarkEntity {
        return .init(id: id,
                     weather: weather,
                     lat: location.lat,
                     lon: location.lon,
                     date: date,
                     mood: mood,
                     hasWritten: hasWritten)
    }
    
    func toDomain()-> Bookmark {
        return .init(id: id,
                     mood: Mood(string: mood),
                     weather: Weather(weather: Weather.WeatherCase(rawValue: weather)!),
                     date: date,
                     location: location.toDomain(),
                     hasWritten: hasWritten)
    }
}

extension Bookmark {
    func toDTO()-> BookmarkRequestDTO {
        return .init(id: id,
                     weather: weather.weather.rawValue,
                     location: location.toDTO(),
                     date: date,
                     mood: mood.mood.text,
                     hasWritten: hasWritten)
    }
}

extension BookmarkRequestDTO {
    func toEntity()-> BookmarkEntity {
        return .init(id: id,
                     weather: weather,
                     lat: location.lat,
                     lon: location.lon,
                     date: date,
                     mood: mood,
                     hasWritten: hasWritten)
    }
}

extension LocationDTO {
    func toDomain()-> Location {
        return .init(lat: lat, lon: lon)
    }
}

extension Location {
    func toDTO()-> LocationDTO {
        return .init(lat: lat, lon: lon)
    }
}
