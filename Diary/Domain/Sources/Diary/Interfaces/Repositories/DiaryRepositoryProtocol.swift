//
//  DiaryRepository.swift
//  Domain
//
//  Created by inforex on 2022/09/16.
//

import Foundation

public protocol DiaryRepositoryProtocol{
    // TODO: 조건별 Fetch 추가
    func fetchDiaryList(completion: @escaping (Result<DiaryList, Error>) -> Void)
    
    func addDiary(diary: Diary, completion: @escaping(Result<DiaryList, Error>) -> Void)
    
    func deleteDiary(id: Diary.Identifier, completion: @escaping(Result<DiaryList, Error>) -> Void)
    
    func updateDiary(diary: Diary, completion: @escaping(Result<DiaryList, Error>) -> Void)
    
    func fetchListByDate(_ date: String, completion: @escaping(BookmarkList) -> Void)
    
    func fetchDateofContents(_ month: String, completion: @escaping(BookmarkList) -> Void)
    
}
