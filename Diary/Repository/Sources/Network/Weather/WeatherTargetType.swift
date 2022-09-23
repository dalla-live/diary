//
//  WeatherTargetType.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/16.
//

import Foundation
import Moya

//🔎 참고: https://github.com/Moya/Moya/blob/master/docs/Targets.md

public enum WeatherTargetType {
    case requestCurrentWeather(WeatherRequestDTO)
}

extension WeatherTargetType: BaseTargetType {
    public var baseURL: URL {
        return URL(string: NetworkURL.openWeatherMapUrl)!
    }
    
    public var path: String {
        switch self {
        case .requestCurrentWeather(_):
            return "/data/2.5/weather"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .requestCurrentWeather(_):
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case.requestCurrentWeather(let model):
            return .requestParameters(parameters: model.toDictionary!, encoding: URLEncoding.queryString)
        }
    }
    
    
}
