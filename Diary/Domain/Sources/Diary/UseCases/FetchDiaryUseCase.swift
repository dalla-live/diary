//
//  FetchDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

public protocol FetchDiaryUseCase {
    func execute(completion: @escaping ((Result<DiaryList, Error>) -> Void))
    func getListByDate(_ query : String , completion : @escaping ((Result<DiaryList, Error>) -> Void))
}

public final class DefaultFetchDiaryService: FetchDiaryUseCase {
    private let diaryRepository: DiaryRepositoryProtocol
    
    public init(diaryRepository: DiaryRepositoryProtocol){
        self.diaryRepository = diaryRepository
    }
    
    public func execute(completion: @escaping ((Result<DiaryList, Error>) -> Void)) {
        diaryRepository.fetchDiaryList { result in
            completion(result)
        }
    }
    
    public func getListByDate(_ query: String, completion: @escaping ((Result<DiaryList, Error>) -> Void)) {
        diaryRepository.fetchListByDate(query){ result in
            completion(result)
        }
    }
}
