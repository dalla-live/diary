//
//  AddBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation

public protocol AddBookmarkUseCase {
    func excute(bookmark: Bookmark,
                completion: @escaping ((Result<Bookmark, Error>) -> Void))
}

public final class DefaultAddBookmarkUseCase: AddBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepositoryProtocol
    
    public init(bookmarkRepository: BookmarkRepositoryProtocol) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    public func excute(bookmark: Bookmark, completion: @escaping ((Result<Bookmark, Error>) -> Void)) {
        bookmarkRepository.addBookmark(bookmark: bookmark) { result in
            completion(result)
        }
    }
}
