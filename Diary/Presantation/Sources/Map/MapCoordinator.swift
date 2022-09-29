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


public protocol MapViewDelegate: AnyObject {
    func openMapViewEdit()
}

public class MapCoordinator: Coordinator {
    
    public var childCoordinator: [Coordinator]  = []
    private var navigationController: UINavigationController
    weak var coordinator : MainCoordinator?
    
    public init(navigation: UINavigationController) {
        navigationController = navigation
        navigation.view.backgroundColor = .blue
    }
    
    public func start() {
        let mapVc = PlaceViewController(dependency: getMapViewModel())
            mapVc.coordinator = self
        self.navigationController.pushViewController(mapVc, animated: false)
    }
    
//    func getMapService() -> MapService {
//        return GoogleMapServiceProvider(service: GPSLocationServiceProvider(), delegate: nil)
//    }
    
    func getMapViewModel() -> MapViewModel {
        
        let mapViewModel    = MapViewModel(
            mapUseCase: MapUseCaseProvider(placeRepo: PlaceRepositoryProvider()))
        return mapViewModel
    }
    
    
    
    deinit {
        print(#file)
    }
    
    
}

extension MapCoordinator: MapViewDelegate {
    public func openMapViewEdit() {
        
        let vc = CommonFormatController()
        navigationController.topViewController?.present(vc, animated: true)
    }
}



