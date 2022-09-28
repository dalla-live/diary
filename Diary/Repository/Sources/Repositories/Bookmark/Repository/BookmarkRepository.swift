//
//  BookmarkRepository.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation
import Domain

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
    
    func addBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Int, Error>) -> Void) {
        completion(storage.add(data: bookmark.toDTO()))
    }
    
    func updateBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Domain.BookmarkList, Error>) -> Void) {
        
    }
    
    func deleteBookmark(id: String, completion: @escaping (Result<Domain.BookmarkList, Error>) -> Void) {
        
    }
}
