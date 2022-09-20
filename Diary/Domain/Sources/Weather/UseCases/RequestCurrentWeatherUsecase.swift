//
//  RequestCurrentWeatherUsecase.swift
//  Domain
//
//  Created by cheonsong on 2022/09/16.
//

import Foundation

public protocol RequestCurrentWeatherUsecase {
    func excute(request: Location,
                completion: @escaping (Result<String,Error>)-> Void)
}

public final class RequestCurrentWeatherService: RequestCurrentWeatherUsecase {
    
    private let currentWeatherRepository: CurrentWeatherRepositoryProtocol
    
    public init(currentWeatherRepository: CurrentWeatherRepositoryProtocol) {
        self.currentWeatherRepository = currentWeatherRepository
    }
    
    public func excute(request: Location,
                       completion: @escaping (Result<String, Error>) -> Void) {
        currentWeatherRepository.requestCurrentWeather(request: request, completion: { (result) in
            completion(result)
        })
    }
}
