//
//  FetchDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

protocol FetchDiaryUseCase {
    func execute(completion: @escaping ((Result<DiaryList, Error>) -> Void))
}

final class DefaultFetchDiaryUseCase: FetchDiaryUseCase {
    private let diaryRepository: DiaryRepository
    
    init(diaryRepository: DiaryRepository){
        self.diaryRepository = diaryRepository
    }
    
    func execute(completion: @escaping ((Result<DiaryList, Error>) -> Void)) {
        diaryRepository.fetchDiaryList(completion: {})
    }
}
