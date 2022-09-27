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
    
    func fetchBookmarkList(completion: @escaping (Domain.BookmarkList) -> Void) {
        let dto = storage.read()
        let domain = dto.map { $0.toDomain() }
        
        completion(BookmarkList(bookmarks: domain))
    }
    
    func addBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Int, Error>) -> Void) {
        let dto = bookmark.toDTO()
        completion(storage.add(data: dto))
    }
    
    func updateBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Domain.BookmarkList, Error>) -> Void) {
        
    }
    
    func deleteBookmark(id: String, completion: @escaping (Result<Domain.BookmarkList, Error>) -> Void) {
        
    }
}
