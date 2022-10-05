//
//  FetchDiaryUseCase.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

public protocol FetchDiaryUseCase {
    func execute(completion: @escaping ((Result<DiaryList, Error>) -> Void))
    func getListByDate(_ query : String , completion : @escaping ((BookmarkList) -> Void))
    func getListByMonth(_ month : String , completion : @escaping ((BookmarkList) -> Void))
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
    
    public func getListByDate(_ query: String, completion: @escaping ((BookmarkList) -> Void)) {
        diaryRepository.fetchListByDate(query){ result in
            print("result :: \(result)")
            completion(result)
        }
    }
    
    public func getListByMonth(_ month: String, completion: @escaping ((BookmarkList) -> Void)) {
        diaryRepository.fetchDateofContents(month){ result in
            completion(result)
        }
    }
    
}
