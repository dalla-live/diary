//
//  DiaryCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import Util

public protocol DiaryCoordinatorDependencies {
    func makeCalenderViewController(action : CalendarViewModelAction ) -> CalendarViewController
    func makeWriteDiaryViewController(coordinator: DiaryCoordinator) -> WriteDiaryViewController
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
        let action = CalendarViewModelAction(showDiaryVC: writeDiaryViewControllerStart)
        
        let vc = dependencies.makeCalenderViewController(action: action)
    
        navigationController.pushViewController(vc, animated: true)
        print(#file)
    }
    
    public func writeDiaryViewControllerStart() {
        let vc = dependencies.makeWriteDiaryViewController(coordinator: self)
        
        self.navigationController.present(vc, animated: true)
//        self.navigationController.pushViewController(vc, animated: false)
    }
    
    deinit {
        print(#file)
    }
}
