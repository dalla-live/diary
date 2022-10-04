//
//  VideoDIContainer.swift
//  App
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import Domain
import Repository
import Presantation
import UIKit

final class VideoDIContainer {
    init() { }
    
    // MARK: ViewModel
    func makeVideoViewModel()-> VideoViewModel {
        return VideoViewModel()
    }
    
    func makeVideoCoordinator(navigationController: UINavigationController) -> VideoCoordinator {
        return VideoCoordinator(navigation: navigationController, dependencies: self)
    }
}

extension VideoDIContainer: VideoCoordinatorDependencies {
    func makeVideoViewController() -> VideoViewController {
        return VideoViewController.create(viewModel: makeVideoViewModel())
    }
}
