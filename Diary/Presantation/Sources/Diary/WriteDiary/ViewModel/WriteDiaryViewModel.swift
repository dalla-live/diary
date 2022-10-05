//
//  WriteDiaryViewModel.swift
//  Presantation
//
//  Created by inforex on 2022/09/20.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

protocol WriteDiaryOutput {
    var bookmark : BehaviorRelay<Bookmark> { get }
}

public class WriteDiaryViewModel : WriteDiaryOutput {

    
    private var weatherUsecase: RequestCurrentWeatherUsecase
    private var updateDiaryUsecase: UpdateDiaryUseCase

    var bookmark: BehaviorRelay<Bookmark> = .init(value: Bookmark())
    
    public init(weatherUsecase: RequestCurrentWeatherUsecase, updateDiaryUsecase: UpdateDiaryUseCase, bookmark : Bookmark) {
        self.weatherUsecase = weatherUsecase
        self.updateDiaryUsecase = updateDiaryUsecase
        self.bookmark.accept(bookmark)
        print("bookmark :: \(bookmark)")
    }
    
}
