//
//  Location.swift
//  DomainTests
//
//  Created by inforex_imac on 2022/09/16.
//

import Foundation
import CoreLocation

struct LocationEntity {
    //   = UUID().uuidString
    var id : String
    var location : Position
    var locations : [Position]
}

struct Position {
    var location : CLLocationCoordinate2D
}

