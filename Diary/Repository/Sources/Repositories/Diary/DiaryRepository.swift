//
//  DiaryRepository.swift
//  RepositoryTests
//
//  Created by inforex on 2022/09/20.
//

import Foundation
import Domain

public final class DiaryRepository: DiaryRepositoryProtocol {
    
    private let storage : BookmarkStorage
    
    public init(storage : BookmarkStorage) {
        self.storage = storage
    }
    
    public func fetchDiaryList(completion: @escaping (Result<DiaryList, Error>) -> Void){
        print(#function)
    }
    
    public func addDiary(diary: Diary, completion: @escaping(Result<DiaryList, Error>) -> Void){
        print(#function)
    }
    
    public func deleteDiary(id: Diary.Identifier, completion: @escaping(Result<DiaryList, Error>) -> Void){
        print(#function)
    }
    
    public func updateDiary(diary: Diary, completion: @escaping(Result<DiaryList, Error>) -> Void){
        print(#function)
    }
    
    // 해당 일에 따라 북마크 & 일기 리스트
    public func fetchListByDate(_ date: String, completion: @escaping(BookmarkList) -> Void){
        let requestDto = BookmarkFetchDTO(query: .month(date), page: 1)
        let responseData  = storage.read(requestDto).toDomain()
        completion(responseData)
        print(#function)
    }
    
    // 해당 월에 따라 북마크 & 일기가 존재하는 날짜
    public func fetchDateofContents(_ month : String , completion : @escaping(BookmarkList) -> Void) {
        let requestDto = BookmarkFetchDTO(query: .month(month), page: 1)
        let responseData  = storage.read(requestDto).toDomain()
        completion(responseData)
        print(#function)
    }
}
