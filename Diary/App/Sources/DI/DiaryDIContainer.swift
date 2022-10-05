//
//  DiaryDIContainer.swift
//  App
//
//  Created by inforex on 2022/09/20.
//

import Foundation
import Domain
import Repository
import Presantation
import Service
import UIKit


final class DiaryDIContainer {
    
    init() {}
    
    // MARK: Repository
    func makeCurrentWeatherRepository()-> CurrentWeatherRepository {
        return CurrentWeatherRepository()
    }
    
    func makeDiaryRepository()-> DiaryRepository {
        return DiaryRepository(storage: BookmarkStorage())
    }
    
    // MARK: Usecase
    func makeRequestCurrentWeatherUsecase()-> RequestCurrentWeatherUsecase {
        return RequestCurrentWeatherService(currentWeatherRepository: makeCurrentWeatherRepository())
    }
        // TODO: Add, Delete, Update, Fetch Usecase들을 따로 둬야 좋을까?
    func makeAddDiaryUseCase() -> AddDiaryUseCase {
        return DefaultAddDiaryService(diaryRepository: makeDiaryRepository())
    }
    
    func makeDeleteDiaryUseCase() -> DeleteDiaryUseCase {
        return DefaultDeleteDiaryService(diaryRepository: makeDiaryRepository())
    }
    
    func makeFetchDiaryUseCase() -> FetchDiaryUseCase {
        return DefaultFetchDiaryService(diaryRepository: makeDiaryRepository())
    }
    
    func makeUpdateDiaryUseCase() -> UpdateDiaryUseCase {
        return DefaultUpdateDiaryService(diaryRepository: makeDiaryRepository())
    }
    
    // MARK: ViewModel
    func makeWriteDiaryViewModel(bookmark : Bookmark) -> WriteDiaryViewModel {
        return WriteDiaryViewModel(weatherUsecase: makeRequestCurrentWeatherUsecase(),
                                   updateDiaryUsecase: makeUpdateDiaryUseCase(),
                                   bookmark : bookmark)
    }
    
    func makeCalendarViewModel(action : CalendarViewModelAction) -> CalendarViewModel {
        return CalendarViewModel(usecase: makeFetchDiaryUseCase(), action: action)
    }
    
    // MARK: Service
    func makeSpeechRecognizer() -> SpeechRecognizer {
        return SpeechRecognizer()
    }
    
    // MARK: Coordinator
    func makeDiaryCoordinator(navigationController: UINavigationController) -> DiaryCoordinator {
        return DiaryCoordinator(navigation: navigationController, dependencies: self)
    }
}

extension DiaryDIContainer: DiaryCoordinatorDependencies {

    func makeWriteDiaryViewController(coordinator: DiaryCoordinator, bookmark : Bookmark ) -> WriteDiaryViewController {
        return WriteDiaryViewController.create(viewModel: makeWriteDiaryViewModel(bookmark: bookmark), coordinator: coordinator, speechRecognizer: makeSpeechRecognizer())
    }
    
    func makeCalenderViewController(action : CalendarViewModelAction) -> CalendarViewController {
        return CalendarViewController.create(with: makeCalendarViewModel(action: action))
    }
    

}
