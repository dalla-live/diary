//
//  CommonFormatViewModel.swift
//  Presantation
//
//  Created by chuchu on 2022/09/29.
//

import Foundation
import Domain
import RxCocoa
import RxSwift

import CoreLocation

public struct CommonAction {
    var didSuccess: (() -> Void)?
    var defaultLocation: Location?
}


protocol CommonFormatViewModelInput {
    var type: CommonFormatController.BehaviorType { get }
    func viewDidload()
    func viewDidload(location: Location, completion: ((Weather.WeatherCase.RawValue) -> ())?)
    
    func didChangeLocation()
    func didTapCancel()
    func didTapSave(bookmark: Bookmark, completion: ((Int) -> ())?)
}

protocol CommonFormatViewModelOutput {
    
}

protocol CommonFormatViewModelProtocol: CommonFormatViewModelInput, CommonFormatViewModelOutput { }

public class CommonFormatViewModel: CommonFormatViewModelProtocol {
    
    private var commonFormatUseCase: CommonFormatBookmarkUseCase
    private var disposeBag = DisposeBag()
    
    struct Model {
        let weather: Weather
    }
    
    var type: CommonFormatController.BehaviorType
    var actions: CommonAction?
    
    var location: Location? = nil
    
    public init(commonFormatBookmarkUseCase: CommonFormatBookmarkUseCase) {
        self.commonFormatUseCase = commonFormatBookmarkUseCase
        self.type = .bookmarkAdd
    }
    
    public init(commonFormatBookmarkUseCase: CommonFormatBookmarkUseCase, actions: CommonAction?) {
        self.commonFormatUseCase = commonFormatBookmarkUseCase
        self.actions = actions
        self.type = .bookmarkAdd
    }
    
    func viewDidload() {
        self.location = self.actions?.defaultLocation
        
        print("CommonFormatViewviewDidload \(self.actions?.defaultLocation)")
    }
    
    func viewDidload(location: Location, completion: ((Weather.WeatherCase.RawValue) -> ())? = nil) {
        commonFormatUseCase.weatherUsecase.excute(request: location) { result in
            switch result {
            case .success(let success):
                guard let tag = Weather(english: success)?.weather.rawValue else { return }
                completion?(tag)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didChangeLocation() {

    }
    
    func didTapCancel() {

    }
    
    func didTapSave(bookmark: Bookmark, completion: ((Int) -> ())? = nil) {
        print(bookmark)
        self.commonFormatUseCase.addBookmarkUsecase.excute(bookmark: bookmark) { result in
            switch result {
            case .success(let success):
                print(success.id)
                self.actions?.didSuccess?()
                completion?(success.id)
            case .failure(let error):
                print(error.localizedDescription)
                completion?(-1)
            }
        }
    }
    
    deinit {
        print(#file.fileName, #function)
    }
}

public struct CommonFormatBookmarkUseCase {
    let weatherUsecase: RequestCurrentWeatherUsecase
    let addBookmarkUsecase: AddBookmarkUseCase
    let updateBookmarkUseCase: UpdateBookmarkUseCase
    
    public init(weatherUsecase: RequestCurrentWeatherUsecase, addBookmarkUsecase: AddBookmarkUseCase, updateBookmarkUseCase: UpdateBookmarkUseCase) {
        self.weatherUsecase = weatherUsecase
        self.addBookmarkUsecase = addBookmarkUsecase
        self.updateBookmarkUseCase = updateBookmarkUseCase
    }
}


