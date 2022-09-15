//
//  Bookmark.swift
//  DomainTests
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import CoreLocation

struct Bookmark: Equatable, Identifiable {
    typealias Identifier = String
    
    let id: Identifier
    let weather: String
    let latitude: String
    let longtitude: String
    let mood: String
    let hasWritten: Bool
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(self.latitude) ?? .zero,
                                      longitude: CLLocationDegrees(self.longtitude) ?? .zero)
    }
}

struct BookmarkList: Equatable {
    let bookmarks: [Bookmark]
}
