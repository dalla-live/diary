//
//  WriteDiaryViewModel.swift
//  Presantation
//
//  Created by inforex on 2022/09/20.
//

import Foundation
import Domain

public class WriteDiaryViewModel {
    
    private var weatherUsecase: RequestCurrentWeatherUsecase
    private var updateDiaryUsecase: UpdateDiaryUseCase
    
    public init(weatherUsecase: RequestCurrentWeatherUsecase, updateDiaryUsecase: UpdateDiaryUseCase) {
        self.weatherUsecase = weatherUsecase
        self.updateDiaryUsecase = updateDiaryUsecase
    }
    
}
