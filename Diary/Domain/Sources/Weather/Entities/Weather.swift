//
//  Weather.swift
//  Domain
//
//  Created by cheonsong on 2022/09/22.
//

import Foundation

public struct Weather {
    public enum WeatherCase: Int, CaseIterable {
        case clear        // 맑음
        case rain         // 비
        case clouds       // 구름
        case snow         // 눈
        case atmosphere   // 안개
        case thunderstorm // 폭풍
        case drizzle      // 이슬비
        
        public var text: String {
            switch self {
            case .clear: return "맑음"
            case .rain: return "비"
            case .clouds: return "구름"
            case .snow: return "눈"
            case .atmosphere: return "안개"
            case .thunderstorm: return "폭풍"
            case .drizzle: return "이슬비"
            }
        }
        
        public var textEng: String {
            switch self {
            case .clear: return "clear"
            case .rain: return "rain"
            case .clouds: return "clouds"
            case .snow: return "snow"
            case .atmosphere: return "atmosphere"
            case .thunderstorm: return "thunderstorm"
            case .drizzle: return "drizzle"
            }
        }
        
        public var emoticon: String {
            switch self {
            case .clear: return "☀️"
            case .rain: return "🌧"
            case .clouds: return "☁️"
            case .snow: return "❄️"
            case .atmosphere: return "🌫"
            case .thunderstorm: return "🌪"
            case .drizzle: return "☔️"
            }
        }
    }
    
    public var weather: WeatherCase
    
    public init(weather: WeatherCase) {
        self.weather = weather
    }
    
    public init(string weather: String) {
        print(weather)
        var weatherCase: WeatherCase {
            switch weather {
            case WeatherCase.clear.text: return .clear
            case WeatherCase.rain.text: return .rain
            case WeatherCase.clouds.text: return .clouds
            case WeatherCase.snow.text: return .snow
            case WeatherCase.atmosphere.text: return .atmosphere
            case WeatherCase.thunderstorm.text: return .thunderstorm
            case WeatherCase.drizzle.text: return .drizzle
            default: return .clear
            }
        }
        
        self.weather = weatherCase
    }
    
    public init?(english weather: String) {
        guard let englishWeather = WeatherCase.allCases.filter({ $0.textEng == weather.lowercased() }).first else { return nil }
        self.weather = englishWeather
    }
    
    public init?(emoticon weather: String) {
        guard let emoticonWeather = WeatherCase.allCases.filter({ $0.emoticon == weather }).first else { return nil }
        self.weather = emoticonWeather
    }
}
