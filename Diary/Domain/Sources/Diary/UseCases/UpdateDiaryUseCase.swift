//
//  UpdateDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

protocol UpdateDiaryUseCase {
    func execute(diary: Diary, completion: @escaping ((Result<DiaryList, Error>) -> Void))
}

final class DefaultUpdateDiaryUseCase: UpdateDiaryUseCase {
    private let diaryRepository: DiaryRepository
    
    init(diaryRepository:DiaryRepository) {
        self.diaryRepository = diaryRepository
    }
    
    func execute(diary: Diary, completion: @escaping ((Result<DiaryList, Error>) -> Void)) {
        diaryRepository.updateDiary(diary: diary) { result in
            completion(result)
        }
    }
}
