//
//  Weather.swift
//  Domain
//
//  Created by cheonsong on 2022/09/22.
//

import Foundation

public struct Weather {
    public enum WeatherCase: String {
        case thunderstorm
        case drizzle
        case rain
        case snow
        case atmosphere
        case clear
        case clouds
    }
    
    public var weather: WeatherCase
    
    public init(weather: WeatherCase) {
        self.weather = weather
    }
}


