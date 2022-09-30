//
//  CommonFormatCoordinator.swift
//  Presantation
//
//  Created by chuchu on 2022/09/28.
//

import Foundation
import UIKit
import Util
import Domain

public protocol CommonForrmatCoordinatorDependencies {
    func makeCommonFormatController(type: CommonFormatController.BehaviorType, bookmark: Bookmark?) -> CommonFormatController
}

public class CommonFormatCoordinator: Coordinator {
    public var childCoordinator: [Coordinator] = []
    public var navigationController: UIViewController
    private let dependencies: CommonForrmatCoordinatorDependencies
    
    public init(navigation: UINavigationController,
                dependencies: CommonForrmatCoordinatorDependencies) {
        navigationController = navigation
        self.dependencies = dependencies
    }
    
    public func start() {
        let commonFormatVC = dependencies.makeCommonFormatController(type: .bookmarkAdd, bookmark: nil)
        commonFormatVC.coordinator = self
        
        self.navigationController.present(commonFormatVC, animated: true)
    }
    
    public func start(to navi: UINavigationController ,type: CommonFormatController.BehaviorType, bookmark: Bookmark? = nil) {
        let CommonFormatVC = dependencies.makeCommonFormatController(type: type, bookmark: bookmark)
        CommonFormatVC.coordinator = self
        
        navi.topViewController?.present(CommonFormatVC, animated: true)
    }
}
