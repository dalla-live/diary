//
//  LoadBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import CoreLocation

public protocol LoadBookmarkUseCase {
    func excute(query: BookmarkQuery, page: Int, completion: @escaping (BookmarkList) -> Void)
    
}

public final class DefaultLoadBookmarkUseCase: LoadBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepositoryProtocol
    
    public init(bookmarkRepository: BookmarkRepositoryProtocol) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    public func excute(query: BookmarkQuery, page: Int, completion: @escaping (BookmarkList) -> Void) {
        bookmarkRepository.fetchBookmarkList(query: query, page: page) { completion($0) }
    }
}
