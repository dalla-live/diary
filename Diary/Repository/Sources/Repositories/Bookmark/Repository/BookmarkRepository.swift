//
//  BookmarkRepository.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation
import Domain
import Util

class BookmarkRepository: BookmarkRepositoryProtocol {
    
    private let storage: BookmarkStorage
    
    init(storage: BookmarkStorage) {
        self.storage = storage
    }
    
    func fetchBookmarkList(query: BookmarkQuery, page: Int, completion: @escaping (Domain.BookmarkList) -> Void) {
        let requestDto = BookmarkFetchDTO(query: query, page: page)
        let responseData = storage.read(requestDto)
        
        completion(responseData.toDomain())
    }
    
    func addBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Domain.Bookmark, Error>) -> Void) {
        
        switch storage.add(data: bookmark.toDTO()) {
        case .success(let dto):
            completion(.success(dto.toDomain()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func updateBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Domain.Bookmark, Error>) -> Void) {
        switch storage.update(data: bookmark.toDTO()) {
        case .success(let dto):
            completion(.success(dto.toDomain()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func deleteBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Void, Error>) -> Void) {

        switch storage.delete(bookmark.toDTO()) {
        case .success():
            completion(.success(()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
