//
//  PlaceCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxGesture
import Util
import Domain
import Service
import Repository

public protocol PlaceCoordinatorDependencies {
    func makePlaceViewController() -> PlaceViewController
    func makeCommonFormatCoordinator(navigationController: UINavigationController) -> Presantation.CommonFormatCoordinator
    func makeCommonFormatController(actions: CommonAction ) ->  Presantation.CommonFormatController
}

public protocol PlaceDelegate: AnyObject {
    func openMapViewEditWith(location: Location?)
}

public class PlaceCoordinator: Coordinator {
    
    public var childCoordinator: [Coordinator]  = []
    private var navigationController: UINavigationController
    weak var coordinator : MainCoordinator?
    var dependencies: PlaceCoordinatorDependencies
    
    public init(navigation: UINavigationController, dependencies: PlaceCoordinatorDependencies) {
        navigationController = navigation
        self.dependencies = dependencies
        navigation.view.backgroundColor = .blue
    }
    
    public func start() {
        let mapVc = dependencies.makePlaceViewController()
            mapVc.coordinator = self
        self.navigationController.pushViewController(mapVc, animated: false)
    }
    
    deinit {
        print(#file)
    }
    
    
}

extension PlaceCoordinator: PlaceDelegate {
    
    public func didSuccessAddBookMark() {
        
        guard let commonVC = self.navigationController.visibleViewController as? CommonFormatController else {
            return
        }
        
        commonVC.dismiss(animated: true, completion: {
            guard let placeVC = self.navigationController.visibleViewController as? PlaceViewController else {
                return
            }
            placeVC.reloadList()
        })
        
        
    }
    
    public func openMapViewEditWith(location: Location?) {
        // 델리게잇 클로저 전달
        let action = CommonAction(didSuccess: didSuccessAddBookMark, defaultLocation: location)
        let vc = dependencies.makeCommonFormatController(actions: action)
        self.navigationController.present(vc, animated: true)
    }
}


