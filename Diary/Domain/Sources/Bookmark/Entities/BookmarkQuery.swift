//
//  BookmarkQuery.swift
//  Domain
//
//  Created by cheonsong on 2022/09/28.
//

import Foundation
import CoreLocation

public enum BookmarkQuery {
    case all                                // 전체 데이터
    case month(String)                      // 원하는 날짜의 데이터
    case id(Int)                            // 원하는 ID의 데이터
    case location(CLLocationCoordinate2D)   //
}


