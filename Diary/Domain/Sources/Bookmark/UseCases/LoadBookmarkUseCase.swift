//
//  LoadBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import CoreLocation

protocol LoadBookmarkUseCase {
    func excute(query: BookmarkQuery, page: Int, completion: @escaping (BookmarkList) -> Void)
    
}

final class DefaultLoadBookmarkUseCase: LoadBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepositoryProtocol
    
    init(bookmarkRepository: BookmarkRepositoryProtocol) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    func excute(query: BookmarkQuery, page: Int, completion: @escaping (BookmarkList) -> Void) {
        bookmarkRepository.fetchBookmarkList(query: query, page: page) { completion($0) }
    }
}
