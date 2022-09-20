//
//  MapCoordinator.swift
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

class MapCoordinator: Coordinator {
    var childCoordinator: [Coordinator]  = []
    var navigationController: UINavigationController
    weak var coordinator : MainCoordinator?
    
    init(navigation: UINavigationController) {
        navigationController = navigation
        navigation.view.backgroundColor = .blue
    }
    
    func start() {
        let mapVc = MapViewController(dependency: getMapViewModel(), service: getMapService())
            mapVc.coordinator = self
        self.navigationController.pushViewController(mapVc, animated: false)
    }
    
    func getMapService() -> MapService {
        return GoogleMapServiceProvider(service: GPSLocationServiceProvider(), delegate: nil)
    }
    
    func getMapViewModel() -> MapViewModel {
        
        let mapViewModel    = MapViewModel(
            mapUseCase: MapUseCaseProvider())
        return mapViewModel
    }
    
    
    
    deinit {
        print(#file)
    }
    
    
}

extension MapCoordinator: MapViewDelegate {
    public func openWindow() {
        coordinator?.presentFullScreenLayer()
    }
}



public protocol MapViewDelegate: AnyObject {
    func openWindow()
}

