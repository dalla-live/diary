//
//  UpdateDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

public protocol UpdateDiaryUseCase {
    func execute(diary: Diary, completion: @escaping ((Result<DiaryList, Error>) -> Void))
}

public final class DefaultUpdateDiaryService: UpdateDiaryUseCase {
    private let diaryRepository: DiaryRepository
    
    public init(diaryRepository:DiaryRepository) {
        self.diaryRepository = diaryRepository
    }
    
    public func execute(diary: Diary, completion: @escaping ((Result<DiaryList, Error>) -> Void)) {
        diaryRepository.updateDiary(diary: diary) { result in
            completion(result)
        }
    }
}
