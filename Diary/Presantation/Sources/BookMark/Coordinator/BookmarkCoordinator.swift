//
//  BookmarkCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import Util

// 의존성 주입을 위한 Coordinator Dependency
public protocol BookmarkCoordinatorDependencies {
    func makeBookmarkViewController()-> BookmarkViewController
}

public class BookmarkCoordinator: Coordinator {
    public var childCoordinator: [Coordinator] = []
    public var navigationController: UINavigationController
    private let dependencies: BookmarkCoordinatorDependencies
    
    
    public init(navigation: UINavigationController,
                dependencies: BookmarkCoordinatorDependencies) {
        navigationController = navigation
        navigation.view.backgroundColor = .white
        self.dependencies = dependencies
    }
    
    public func start() {
        let bookmarVC = dependencies.makeBookmarkViewController()
        bookmarVC.coordinator = self
        
        self.navigationController.pushViewController(bookmarVC, animated: false)
        print(#file)
    }
    
    deinit {
        print(#file)
    }
    
    
}
