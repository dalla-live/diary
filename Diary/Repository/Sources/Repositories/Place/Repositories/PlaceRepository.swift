//
//  PlaceRepository.swift
//  Repository
//
//  Created by John Park on 2022/09/25.
//

import Foundation
import Domain
import Util


public class PlaceRepository: PlaceRepositoryProtocol {
    
    private let storage: BookmarkStorage
    
    public init(storage: BookmarkStorage) {
        self.storage = storage
    }
    
    public func fetchBookmarkList(query: BookmarkQuery, page: Int, completion: @escaping (Domain.BookmarkList) -> Void) {
        let requestDto = BookmarkFetchDTO(query: query, page: page)
        let responseData = storage.read(requestDto)
        
        completion(responseData.toDomain())
    }
    
    public func addBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Domain.Bookmark, Error>) -> Void) {
        
        switch storage.add(data: bookmark.toDTO()) {
        case .success(let dto):
            completion(.success(dto.toDomain()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    public func updateBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Domain.Bookmark, Error>) -> Void) {
        switch storage.update(data: bookmark.toDTO()) {
        case .success(let dto):
            completion(.success(dto.toDomain()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    public func deleteBookmark(bookmark: Domain.Bookmark, completion: @escaping (Result<Void, Error>) -> Void) {

        switch storage.delete(bookmark.toDTO()) {
        case .success():
            completion(.success(()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    public func deleteAllData() {
        storage.deleteAll()
    }
    
    public func fetchList() {
        
    }
    
    public func requestAddress(request: Location, completion: @escaping (Result<String, Error>) -> Void) {
        PlaceAPI.requestAddress(request: NaverPlaceRequestDTO(lat: request.lat, lng: request.lon), completion: { (result) in
            completion(result)
        })
    }
    
}
