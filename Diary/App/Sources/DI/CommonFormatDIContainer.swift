//
//  CommonFormatDIContainer.swift
//  App
//
//  Created by chuchu on 2022/09/28.
//

import Foundation
import Domain
import Repository
import Presantation
import UIKit

final class CommonFormatDIContainer {
    
    init() {}
    
    // MARK: Repository
    func makeCurrentWeatherRepository()-> CurrentWeatherRepository {
        return CurrentWeatherRepository()
    }
    
    // MARK: Usecases
    func makeRequestCurrentWeatherUsecase()-> RequestCurrentWeatherUsecase {
        return RequestCurrentWeatherService(currentWeatherRepository: makeCurrentWeatherRepository())
    }
    
    // MARK: ViewModel
    func makeCommonFormatViewModel()-> BookmarkViewModel {
        return BookmarkViewModel(usecase: makeRequestCurrentWeatherUsecase())
    }
    
    // MARK: Coordinator
    func makeCommonFormatCoordinator(navigationController: UINavigationController) -> CommonFormatCoordinator {
        return CommonFormatCoordinator(navigation: navigationController, dependencies: self)
    }
}

extension CommonFormatDIContainer: CommonForrmatCoordinatorDependencies {
    // MARK: Viewcontroller
    func makeCommonFormatCoordinator(type: CommonFormatController.BehaviorType, bookmark: Bookmark? = nil) -> CommonFormatController {
        return CommonFormatController.create(with: type)
    }
}
