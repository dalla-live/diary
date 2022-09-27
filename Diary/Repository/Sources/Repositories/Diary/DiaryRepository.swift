//
//  DiaryRepository.swift
//  RepositoryTests
//
//  Created by inforex on 2022/09/20.
//

import Foundation
import Domain

public final class DiaryRepository: DiaryRepositoryProtocol {
    
    public init() {}
    
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
    public func fetchListByDate(_ date: String, completion: @escaping(Result<DiaryList, Error>) -> Void){
        print(#function)
    }
    
    // 해당 월에 따라 북마크 & 일기가 존재하는 날짜
    public func fetchDateofContents(_ month : String , completion : @escaping([String]) -> Void) {
        completion(["2022.09.11", "2022.09.17", "2022.09.18"])
        print(#function)
    }
}
