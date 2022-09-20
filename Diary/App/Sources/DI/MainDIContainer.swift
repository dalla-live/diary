//
//  MainDIContainer.swift
//  App
//
//  Created by cheonsong on 2022/09/19.
//

import UIKit
import Foundation
import Presantation

final class MainDIContainer {
    
    public init() {}
    
    /// MainCoordinator 생성
    func makeMainCoordinator(tabBarController: DiaryTabbarController)-> MainCoordinator {
        return MainCoordinator(coordinator: tabBarController, dependencies: self)
    }
    
    /// Bookmark DI Container 생성
    public func makeBookmarkDIContainer()-> BookmarkDIContainer {
        return BookmarkDIContainer()
    }
}

extension MainDIContainer: MainCoordinatorDependencies {
    func makeBookmarkCoordinator(navigationController: UINavigationController) -> BookmarkCoordinator {
        let diContainer = BookmarkDIContainer()
        return diContainer.makeBookmarkCoordinator(navigationController: navigationController)
    }
    
    func makeDiaryCoordinator(navigationController: UINavigationController) -> DiaryCoordinator {
        let diContainer = DiaryDIContainer()
        return diContainer.makeDiaryCoordinator(navigationController: navigationController)
    }
    
    func makeMapCoordinator(navigationController: UINavigationController) -> MapCoordinator {
        return MapCoordinator(navigation: navigationController)
    }
}
