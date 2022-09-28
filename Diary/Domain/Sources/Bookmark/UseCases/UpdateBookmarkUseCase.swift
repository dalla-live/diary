//
//  UpdateBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation

protocol UpdateBookmarkUseCase {
    func excute(bookmark: Bookmark,
                completion: @escaping ((Result<Bookmark, Error>) -> Void))
}

final class DefaultUpdateBookmarkUseCase: UpdateBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepositoryProtocol
    
    init(bookmarkRepository: BookmarkRepositoryProtocol) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    func excute(bookmark: Bookmark, completion: @escaping ((Result<Bookmark, Error>) -> Void)) {
        bookmarkRepository.updateBookmark(bookmark: bookmark) { completion($0) }
    }
}
