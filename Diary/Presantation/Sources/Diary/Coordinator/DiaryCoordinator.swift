//
//  DiaryCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import Util

public class DiaryCoordinator: Coordinator {
    public var childCoordinator: [Coordinator]  = []
    public var navigationController: UINavigationController
    
    public init(navigation: UINavigationController) {
        navigationController = navigation
    }
    
    public func start() {
        let vc = CalendarViewController()
            vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
        print(#file)
    }
    
    deinit {
        print(#file)
    }
}

extension DiaryCoordinator : DiaryViewDelegate {
    public func openDiaryView() {
        let vc = DiaryViewController()
        navigationController.present(vc, animated: true)
    }
}

public protocol DiaryViewDelegate : AnyObject {
    func openDiaryView()
}
