//
//  VideoCoordinator.swift
//  PresantationTests
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import UIKit
import Util

public protocol VideoCoordinatorDependencies {
    func makeVideoViewController() -> VideoViewController
}

public class VideoCoordinator: Coordinator {
    public var childCoordinator: [Coordinator]  = []
    public var navigationController: UINavigationController
    var dependencies: VideoCoordinatorDependencies
    
    public init(navigation: UINavigationController,
                dependencies: VideoCoordinatorDependencies) {
        navigationController = navigation
        self.dependencies = dependencies
    }
    
    public func start(){
        let videoVC = dependencies.makeVideoViewController()
        videoVC.view.backgroundColor = .white
        self.navigationController.pushViewController(videoVC, animated: false)
    }
    
    deinit {
        print(#file)
    }
}
