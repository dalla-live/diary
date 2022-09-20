//
//  DeleteDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

public protocol DeleteDiaryUseCase {
    func execute(id: Diary.Identifier, completion: @escaping ((Result<DiaryList, Error>) -> Void))
}

public final class DefaultDeleteDiaryService: DeleteDiaryUseCase {
    private let diaryRepository: DiaryRepository
    
    public init(diaryRepository: DiaryRepository){
        self.diaryRepository = diaryRepository
    }
    
    public func execute(id: Diary.Identifier, completion: @escaping ((Result<DiaryList, Error>) -> Void)) {
        diaryRepository.deleteDiary(id: id) { result in
            completion(result)
        }
    }
}
