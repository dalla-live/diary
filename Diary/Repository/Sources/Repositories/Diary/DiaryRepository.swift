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
    
    public func fetchListByDate(_ date: String, completion: @escaping(Result<DiaryList, Error>) -> Void){
        print(#function)
    }
}
