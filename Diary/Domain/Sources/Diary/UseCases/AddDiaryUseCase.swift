//
//  AddDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

public protocol AddDiaryUseCase {
    func execute(diary: Diary, completion: @escaping ((Result<DiaryList, Error>) -> Void))
}

public final class DefaultAddDiaryService: AddDiaryUseCase {
    private let diaryRepository: DiaryRepositoryProtocol
    
    public init(diaryRepository:DiaryRepositoryProtocol){
        self.diaryRepository = diaryRepository
    }
    
    public func execute(diary: Diary, completion: @escaping ((Result<DiaryList, Error>) -> Void)){
        diaryRepository.addDiary(diary: diary){ result in
            completion(result)
        }
    }
}
