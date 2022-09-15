//
//  UpdateBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation

protocol UpdateBookmarkUseCase {
    func excute(bookmark: Bookmark,
                completion: @escaping ((Result<BookmarkList, Error>) -> Void))
}

final class DefaultUpdateBookmarkUseCase: UpdateBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepository
    
    init(bookmarkRepository: BookmarkRepository) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    func excute(bookmark: Bookmark, completion: @escaping ((Result<BookmarkList, Error>) -> Void)) {
        bookmarkRepository.updateBookmark(bookmark: bookmark) { completion($0) }
    }
}
