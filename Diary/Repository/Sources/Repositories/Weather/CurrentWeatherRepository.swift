//
//  CurrentWeatherRepository.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/16.
//

import Foundation
import Domain

public final class CurrentWeatherRepository: CurrentWeatherRepositoryProtocol {
    
    public init() {}
    
    public func requestCurrentWeather(request: Location, completion: @escaping (Result<String, Error>) -> Void) {
        
        WeatherAPI.requestCurrentWeather(request: WeatherRequestDTO(lat: request.lat, lon: request.lon), completion: { (result) in
            completion(result)
        })
    }
}
