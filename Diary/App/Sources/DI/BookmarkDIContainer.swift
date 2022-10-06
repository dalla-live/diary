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
    let bookmarkStorage = BookmarkStorage()
    
    init() {}
    
    // MARK: Usecases
    func makeLoadBookmarkUseCase() -> LoadBookmarkUseCase {
        return DefaultLoadBookmarkUseCase(bookmarkRepository: BookmarkRepository(storage: bookmarkStorage))
    }
    
    func makeBookmarkUseCase() -> BookmarkUseCase {
        return BookmarkUseCase(loadBookmarkUseCase: makeLoadBookmarkUseCase())
    }
    
    // MARK: ViewModel
    func makeBookmarkViewModel()-> BookmarkViewModel {
        return BookmarkViewModel(BookmarkBookmarkUseCase: makeBookmarkUseCase())
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
