//
//  DiaryCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import Util

public protocol DiaryCoordinatorDependencies {
    func makeWriteDiaryViewController() -> WriteDiaryViewController
    func makeCalenderViewController(action : CalendarViewModelAction ) -> CalendarViewController
}

public class DiaryCoordinator: Coordinator {
    public var childCoordinator: [Coordinator]  = []
    public var navigationController: UINavigationController
    private var dependencies: DiaryCoordinatorDependencies
    
    public init(navigation: UINavigationController,
                dependencies: DiaryCoordinatorDependencies) {
        navigationController = navigation
        self.dependencies = dependencies
    }
    
    public func start() {
        let action = CalendarViewModelAction(showDiaryVC: WriteDiaryViewControllerStart)
        
        let vc = dependencies.makeCalenderViewController(action: action)
    
        navigationController.pushViewController(vc, animated: true)
        print(#file)
    }
    
    public func WriteDiaryViewControllerStart() {
        let vc = dependencies.makeWriteDiaryViewController()
        vc.coordinator = self
        
        self.navigationController.present(vc, animated: true)
//        self.navigationController.pushViewController(vc, animated: false)
    }
    
    deinit {
        print(#file)
    }
}
