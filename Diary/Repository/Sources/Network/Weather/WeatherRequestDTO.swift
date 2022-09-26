//
//  WeatherDTO.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/16.
//

import Foundation

public struct WeatherRequestDTO: Codable {
    var lat: Double // 위도
    var lon: Double // 경도
    var appid: String = AppKey.openWeatherMapAppKey // API appkey
    var lang: String = "kr" // 출력 언어
}
