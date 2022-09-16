//
//  CurrentWeatherRepository.swift
//  Domain
//
//  Created by cheonsong on 2022/09/16.
//

import Foundation

public protocol CurrentWeatherRepositoryProtocol {
    func requestCurrentWeather(request: Location,
                               completion: @escaping (Result<String, Error>)-> Void)
}
