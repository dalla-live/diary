//
//  BookmarkQuery.swift
//  Domain
//
//  Created by cheonsong on 2022/09/28.
//

import Foundation
import CoreLocation

public enum BookmarkQuery {
    /// 전체 데이터
    case all
    /// 원하는 날짜의 데이터
    /// - Parameter date: "2020.11"
    case month(String)
    /// 원하는 ID의 데이터
    /// - Parameter id: ID key
    case id(Int)
    /// 화면안의 데이터
    /// - Parameter min: 화면 최소 좌표
    /// - Parameter max: 화면 최대 좌표
    case location(CLLocationCoordinate2D, CLLocationCoordinate2D)
}
