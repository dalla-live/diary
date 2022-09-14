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
        navigation.view.backgroundColor = .red
    }
    
    public func start() {
        print(#file)
    }
    
    deinit {
        print(#file)
    }
    
    
}
