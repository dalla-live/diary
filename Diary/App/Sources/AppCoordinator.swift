//
//  AppCoordinator.swift
//  App
//
//  Created by cheonsong on 2022/09/19.
//

import Foundation
import UIKit
import Presantation

class AppCordinator {
    var tabBarController: DiaryTabbarController
    private let appDIContainer: AppDIContainer
    
    init(tabBarController: DiaryTabbarController, appDIContainer: AppDIContainer) {
        self.tabBarController = tabBarController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let mainDIContainer = appDIContainer.makeMainDIContainer()
        let mainCoordinator = mainDIContainer.makeMainCoordinator(tabBarController: tabBarController)
        mainCoordinator.start()
    }
}
