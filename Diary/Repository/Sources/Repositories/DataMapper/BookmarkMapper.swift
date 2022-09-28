//
//  BookmarkMapper.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation
import Domain

extension BookmarkEntity {
    func toDTO()-> BookmarkDTO {
        return .init(id: id,
                     weather: weather,
                     location: .init(lat: lat, lon: lon, address: address),
                     date: date,
                     mood: mood,
                     hasWritten: hasWritten,
                     note: note)
    }
}

extension BookmarkResponseDTO {
    func toDomain()-> BookmarkList {
        return .init(bookmarks: bookmarks.map({ $0.toDomain() }), hasNext: hasNext)
    }
}

extension BookmarkDTO {
    func toDomain()-> Bookmark {
        return .init(id: id,
                     mood: Mood(string: mood),
                     weather: Weather(weather: Weather.WeatherCase(rawValue: weather)!),
                     date: date,
                     location: location.toDomain(),
                     hasWritten: hasWritten,
                     note: note)
    }
    
    func toEntity()-> BookmarkEntity {
        return .init(id: id,
                     weather: weather,
                     lat: location.lat,
                     lon: location.lon,
                     address: location.address,
                     date: date,
                     mood: mood,
                     hasWritten: hasWritten,
                     note: note)
    }
}

extension Bookmark {
    func toDTO()-> BookmarkDTO {
        return .init(id: id,
                     weather: weather.weather.rawValue,
                     location: location.toDTO(),
                     date: date,
                     mood: mood.mood.text,
                     hasWritten: hasWritten,
                     note: note)
    }
}

extension LocationDTO {
    func toDomain()-> Location {
        return .init(lat: lat, lon: lon, address: address)
    }
}

extension Location {
    func toDTO()-> LocationDTO {
        return .init(lat: lat, lon: lon, address: address)
    }
}

func dateFormatter(date: Date)-> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.d" // 2020-08-13 16:30
    let convertStr = dateFormatter.string(from: date)

    return convertStr
}
