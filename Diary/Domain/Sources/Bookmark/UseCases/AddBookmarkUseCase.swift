//
//  AddBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation

protocol AddBookmarkUseCase {
    func excute(bookmark: Bookmark,
                completion: @escaping ((Result<Int, Error>) -> Void))
}

final class DefaultAddBookmarkUseCase: AddBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepositoryProtocol
    
    init(bookmarkRepository: BookmarkRepositoryProtocol) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    func excute(bookmark: Bookmark, completion: @escaping ((Result<Int, Error>) -> Void)) {
        bookmarkRepository.addBookmark(bookmark: bookmark) { result in
            completion(result)
        }
    }
}
