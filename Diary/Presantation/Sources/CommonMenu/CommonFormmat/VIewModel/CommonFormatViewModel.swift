//
//  CommonFormatViewModel.swift
//  Presantation
//
//  Created by chuchu on 2022/09/29.
//

import Foundation
import Domain
import RxSwift

public struct CommonAction {
    var didSuccess: () -> Void
}


protocol CommonFormatViewModelInput {
    var type: CommonFormatController.BehaviorType { get }
    func viewDidload()
    func didChangeLocation()
    func didTapCancel()
    func didTapStore(bookmark: Bookmark)
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
    
    let location = BehaviorSubject<Location>(value: Location(lat: 0, lon: 0, address: ""))
    
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
        // type에 따라서 분기처리해야함
//        switch type {
//        case .bookmarkAdd, .diaryAdd:
//
//        case .bookmarkEdit, .diaryEdit:
//        }
        print("CommonFormatViewviewDidload")
    }
    
    func didChangeLocation() {

    }
    
    func didTapCancel() {

    }
    
    func didTapStore(bookmark: Bookmark) {
        print(bookmark)
        self.commonFormatUseCase.addBookmarkUsecase.excute(bookmark: bookmark) { result in
            switch result {
            case .success(let success):
                print(success.id)
                self.actions?.didSuccess()
            case .failure(let error):
                print(error)
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


