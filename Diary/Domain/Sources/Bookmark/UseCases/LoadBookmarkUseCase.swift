//
//  LoadBookmarkUseCase.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import CoreLocation

protocol LoadBookmarkUseCase {
    func excute(coordinate: CLLocationCoordinate2D,
                completion: @escaping ((Result<BookmarkList, Error>) -> Void))
    
}

final class DefaultLoadBookmarkUseCase: LoadBookmarkUseCase {
    private let bookmarkRepository: BookmarkRepository
    
    init(bookmarkRepository: BookmarkRepository) {
        self.bookmarkRepository = bookmarkRepository
    }
    
    func excute(coordinate: CLLocationCoordinate2D, completion: @escaping ((Result<BookmarkList, Error>) -> Void)) {
        bookmarkRepository.fetchBookmarkList(coordinate: coordinate) { result in
            completion(result)
        }
    }
}
