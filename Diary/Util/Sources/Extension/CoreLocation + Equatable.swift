//
//  CoreLocation + Equatable.swift
//  Util
//
//  Created by inforex_imac on 2022/09/20.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
