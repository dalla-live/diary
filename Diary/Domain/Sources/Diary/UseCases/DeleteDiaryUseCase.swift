//
//  DeleteDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

protocol DeleteDiaryUseCase {
    func execute(id: Diary.Identifier, completion: @escaping ((Result<DiaryList, Error>) -> Void))
}

final class DefaultDeleteDiaryUseCase: DeleteDiaryUseCase {
    private let diaryRepository: DiaryRepository
    
    init(diaryRepository: DiaryRepository){
        self.diaryRepository = diaryRepository
    }
    
    func execute(id: Diary.Identifier, completion: @escaping ((Result<DiaryList, Error>) -> Void)) {
        diaryRepository.deleteDiary(id: id) { result in
            completion(result)
        }
    }
}
