//
//  AddDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

protocol AddDiaryUseCase {
    func execute(diary: Diary, completion: @escaping ((Result<DiaryList, Error>) -> Void))
}

final class defaultAddDiaryUseCase: AddDiaryUseCase {
    private let diaryRepository: DiaryRepository
    
    init(diaryRepository:DiaryRepository){
        self.diaryRepository = diaryRepository
    }
    
    func execute(diary: Diary, completion: @escaping ((Result<DiaryList, Error>) -> Void)){
        diaryRepository.addDiary(diary: diary){ result in
            completion(result)
        }
    }
}
