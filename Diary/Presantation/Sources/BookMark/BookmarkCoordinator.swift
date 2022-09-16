//
//  BookmarkCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import Util

public class BookmarkCoordinator: Coordinator {
    public var childCoordinator: [Coordinator] = []
    public var navigationController: UINavigationController
    
    public init(navigation: UINavigationController) {
        navigationController = navigation
        navigation.view.backgroundColor = .white
    }
    
    public func start() {
        let bookmarVC = BookmarkViewController()
        bookmarVC.coordinator = self
        
        self.navigationController.pushViewController(bookmarVC, animated: false)
        print(#file)
    }
    
    deinit {
        print(#file)
    }
    
    
}
