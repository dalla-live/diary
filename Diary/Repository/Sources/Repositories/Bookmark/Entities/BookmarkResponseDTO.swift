//
//  BookmarkDTO.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation

public struct BookmarkResponseDTO {
    var bookmarks: [BookmarkDTO]
    var hasNext: Bool
    
    init(bookmarks: [BookmarkDTO], hasNext: Bool) {
        self.bookmarks = bookmarks
        self.hasNext = hasNext
    }
}

struct LocationDTO {
    var lat: Double
    var lon: Double
    var address: String
    
    init(lat: Double, lon: Double, address: String) {
        self.lat = lat
        self.lon = lon
        self.address = address
    }
}
