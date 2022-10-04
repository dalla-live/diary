//
//  UpdateBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation

public protocol UpdateBookmarkUseCase {
    func excute(bookmark: Bookmark,
                completion: @escaping ((Result<Bookmark, Error>) -> Void))
}

public final class DefaultUpdateBookmarkUseCase: UpdateBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepositoryProtocol
    
    public init(bookmarkRepository: BookmarkRepositoryProtocol) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    public func excute(bookmark: Bookmark, completion: @escaping ((Result<Bookmark, Error>) -> Void)) {
        bookmarkRepository.updateBookmark(bookmark: bookmark) { completion($0) }
    }
}
