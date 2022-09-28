//
//  DeleteBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation

protocol DeleteBookmarkUseCase {
    func excute(bookmark: Bookmark,
                completion: @escaping ((Result<Void, Error>) -> Void))
}

final class DefaultDeleteBookmarkUseCase: DeleteBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepositoryProtocol
    
    init(bookmarkRepository: BookmarkRepositoryProtocol) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    func excute(bookmark: Bookmark, completion: @escaping ((Result<Void, Error>) -> Void)) {
        bookmarkRepository.deleteBookmark(bookmark: bookmark) { completion($0) }
    }
}
