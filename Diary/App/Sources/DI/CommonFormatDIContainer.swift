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
    
    // MARK: - Persistent Storage
    lazy var bookmarkStorage = BookmarkStorage()
    
    init() {}
    
    // MARK: Repository
    
    // MARK: Usecases
    func makeRequestCurrentWeatherUsecase()-> RequestCurrentWeatherUsecase {
        return RequestCurrentWeatherService(currentWeatherRepository: makeCurrentWeatherRepository())
    }
    
    func makeAddBookmarkUseCase() -> AddBookmarkUseCase {
        return DefaultAddBookmarkUseCase(bookmarkRepository: BookmarkRepository(storage: bookmarkStorage))
    }
    
    func makeUpdateBookmarkUseCase() -> UpdateBookmarkUseCase {
        return DefaultUpdateBookmarkUseCase(bookmarkRepository: BookmarkRepository(storage: bookmarkStorage))
    }
    
    func makeCurrentWeatherRepository() -> CurrentWeatherRepository {
        return CurrentWeatherRepository()
    }
    
    func makeCommonUseCase() -> CommonFormatBookmarkUseCase {
        return CommonFormatBookmarkUseCase(weatherUsecase: makeRequestCurrentWeatherUsecase(),
                                           addBookmarkUsecase: makeAddBookmarkUseCase(),
                                           updateBookmarkUseCase: makeUpdateBookmarkUseCase())
    }
    
    // MARK: ViewModel
    
    func makeCommonFormatViewModel() -> CommonFormatViewModel {
        return CommonFormatViewModel(commonFormatBookmarkUseCase: makeCommonUseCase())
    }
    
    
    // 클로져가 있는 경우
    func makeCommonFormatViewModel(actions: CommonAction?) -> CommonFormatViewModel {
        return CommonFormatViewModel(commonFormatBookmarkUseCase: makeCommonUseCase(), actions: actions)
    }
    
    // MARK: Coordinator
    func makeCommonFormatCoordinator(navigationController: UINavigationController) -> CommonFormatCoordinator {
        return CommonFormatCoordinator(navigation: navigationController, dependencies: self)
    }
    
    func makeCommonFormatController(type: Presantation.CommonFormatController.BehaviorType, actions: CommonAction, bookmark: Domain.Bookmark?) -> Presantation.CommonFormatController {
        return CommonFormatController.create(viewModel: makeCommonFormatViewModel(actions: actions), with: type)
    }
    
}

extension CommonFormatDIContainer: CommonForrmatCoordinatorDependencies {
    func makeCommonFormatController(type: Presantation.CommonFormatController.BehaviorType, bookmark: Domain.Bookmark?) -> Presantation.CommonFormatController {
        return CommonFormatController.create(viewModel: makeCommonFormatViewModel(), with: type)
    }
}

