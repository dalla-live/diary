//
//  BookmarkRepository.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import CoreLocation

protocol BookmarkRepository {
    func fetchBookmarkList(completion: @escaping (Result<BookmarkList, Error>) -> Void)
    
    func addBookmark(bookmark: Bookmark,
                     completion: @escaping (Result<BookmarkList, Error>) -> Void)
    
    func updateBookmark(bookmark: Bookmark,
                        completion: @escaping (Result<BookmarkList, Error>) -> Void)
    
    func deleteBookmark(id: String,
                        completion: @escaping (Result<BookmarkList, Error>) -> Void)
}
