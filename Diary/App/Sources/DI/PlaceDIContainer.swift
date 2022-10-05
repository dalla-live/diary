//
//  PlaceDIContainer.swift
//  App
//
//  Created by inforex_imac on 2022/10/04.
//

import UIKit
import Presantation
import Repository
import Domain


final class PlaceDIContainer {
    
    // MARK: Repository
    func makePlaceRepository()-> PlaceRepositoryProtocol {
        return PlaceRepository(storage: .init())
    }
    
    // MARK: Usecases
    func makePlaceUseCase() -> PlaceUseCase {
        return  PlaceUseCaseProvider(placeRepo:  makePlaceRepository())
    }
    
    // MARK: ViewModel
    func makePlaceViewModel() -> PlaceViewModel {
        let placeViewModel    = PlaceViewModel(placeUseCase: makePlaceUseCase())
        return placeViewModel
    }
    
    
    
    func makePlaceCoordinator(navigationController: UINavigationController) -> Presantation.PlaceCoordinator {
        let placeCoordinator = PlaceCoordinator(navigation: navigationController, dependencies: self)
            return placeCoordinator
    }
}


extension PlaceDIContainer: PlaceCoordinatorDependencies {
    
    func makeCommonFormatCoordinator(navigationController: UINavigationController) -> Presantation.CommonFormatCoordinator {
        let diContainer = CommonFormatDIContainer()
        return diContainer.makeCommonFormatCoordinator(navigationController: navigationController)
    }
    
    func makePlaceViewController() -> Presantation.PlaceViewController {
        return PlaceViewController(dependency: makePlaceViewModel())
    }
    
    func makeCommonFormatController(actions: CommonAction ) ->  Presantation.CommonFormatController {
        let diContainer = CommonFormatDIContainer()
        
        return diContainer.makeCommonFormatController(type: .bookmarkAdd, actions: actions, bookmark: nil)
    }
}




