//
//  DeleteBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation

public protocol DeleteBookmarkUseCase {
    func excute(bookmark: Bookmark,
                completion: @escaping ((Result<Void, Error>) -> Void))
}

public final class DefaultDeleteBookmarkUseCase: DeleteBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepositoryProtocol
    
    public init(bookmarkRepository: BookmarkRepositoryProtocol) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    public func excute(bookmark: Bookmark, completion: @escaping ((Result<Void, Error>) -> Void)) {
        bookmarkRepository.deleteBookmark(bookmark: bookmark) { completion($0) }
    }
}
