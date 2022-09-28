//
//  BookmarkRepository.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import CoreLocation

public protocol BookmarkRepositoryProtocol {
    func fetchBookmarkList(query: BookmarkQuery, page: Int, completion: @escaping (BookmarkList) -> Void)
    
    func addBookmark(bookmark: Bookmark,
                     completion: @escaping (Result<Bookmark, Error>) -> Void)
    
    func updateBookmark(bookmark: Bookmark,
                        completion: @escaping (Result<Bookmark, Error>) -> Void)
    
    func deleteBookmark(id: String,
                        completion: @escaping (Result<BookmarkList, Error>) -> Void)
}
