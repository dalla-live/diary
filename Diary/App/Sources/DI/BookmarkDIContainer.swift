//
//  BookmarkDIContainer.swift
//  App
//
//  Created by cheonsong on 2022/09/19.
//

import Foundation
import Domain
import Repository
import Presantation
import UIKit

final class BookmarkDIContainer {
    
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
    func makeBookmarkViewModel()-> BookmarkViewModel {
        return BookmarkViewModel(usecase: makeRequestCurrentWeatherUsecase())
    }
    
    // MARK: Coordinator
    func makeBookmarkCoordinator(navigationController: UINavigationController)-> BookmarkCoordinator {
        return BookmarkCoordinator(navigation: navigationController, dependencies: self)
    }
}

extension BookmarkDIContainer: BookmarkCoordinatorDependencies {
    func makeCommonFormatCoordinator(navigationController: UINavigationController) -> Presantation.CommonFormatCoordinator {
        let diContainer = CommonFormatDIContainer()
        return diContainer.makeCommonFormatCoordinator(navigationController: navigationController)
    }
    
    
    // MARK: ViewController
    func makeBookmarkViewController() -> BookmarkViewController {
        return BookmarkViewController.create(with: makeBookmarkViewModel())
    }
    
}
