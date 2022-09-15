//
//  DeleteBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation

protocol DeleteBookmarkUseCase {
    func excute(id: String,
                completion: @escaping ((Result<BookmarkList, Error>) -> Void))
}

final class DefaultDeleteBookmarkUseCase: DeleteBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepository
    
    init(bookmarkRepository: BookmarkRepository) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    func excute(id: String, completion: @escaping ((Result<BookmarkList, Error>) -> Void)) {
        bookmarkRepository.deleteBookmark(id: id) { completion($0) }
    }
}
