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
    func makeBookmarkViewController() -> BookmarkViewController
    
    // Child
    func makeCommonFormatCoordinator(navigationController: UINavigationController) -> CommonFormatCoordinator
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
        makeCommonFormatCoordinator()
    }
    
    private func makeCommonFormatCoordinator() {
        let commonFormatCoordinator = dependencies.makeCommonFormatCoordinator(navigationController: self.navigationController)
        childCoordinator.append(commonFormatCoordinator)
    }
    
    public func presentCommonFormatViewController(type: CommonFormatController.BehaviorType) {
        guard let commonFormatCoordinator =  childCoordinator.filter({ $0 is CommonFormatCoordinator }).first as? CommonFormatCoordinator else { return }
        
        commonFormatCoordinator.start(to: self.navigationController, type: .bookmarkAdd)
    }
    
    deinit {
        print(#file)
    }
}
