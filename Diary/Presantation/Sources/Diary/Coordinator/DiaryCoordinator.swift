//
//  DiaryCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import Util

public protocol DiaryCoordinatorDependencies {
    func makeWriteDiaryViewController(coordinator: DiaryCoordinator) -> WriteDiaryViewController
    func makeCalenderViewController(coordinator: DiaryCoordinator) -> CalendarViewController
}

public class DiaryCoordinator: Coordinator {
    public var childCoordinator: [Coordinator]  = []
    public var navigationController: UINavigationController
    var dependencies: DiaryCoordinatorDependencies
    
    public init(navigation: UINavigationController,
                dependencies: DiaryCoordinatorDependencies) {
        navigationController = navigation
        self.dependencies = dependencies
    }
    
    public func start() {
        let vc = dependencies.makeCalenderViewController(coordinator: self)
        
        navigationController.pushViewController(vc, animated: true)
        print(#file)
    }
    
    public func writeDiaryViewControllerStart() {
        let vc = dependencies.makeWriteDiaryViewController(coordinator: self)
        
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    deinit {
        print(#file)
    }
}
// TODO: 삭제해도 될 듯?
extension DiaryCoordinator : DiaryViewDelegate {
    public func openDiaryView() {
        let vc = DiaryViewController()
        navigationController.present(vc, animated: true)
    }
}

public protocol DiaryViewDelegate : AnyObject {
    func openDiaryView()
}
