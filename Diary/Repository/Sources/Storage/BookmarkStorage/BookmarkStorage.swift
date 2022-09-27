//
//  BookmarkStorage.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation
import RxSwift

public class BookmarkStorage {
    private let database = Database<BookmarkEntity>()
    var disposeBag = DisposeBag()
    
    private var bookmarkList: [BookmarkEntity] = []
    
    public init() {
        database.changeSet.subscribe(onNext: { [weak self] entities in
            guard let self = self else { return }
            
            self.bookmarkList = entities
        })
        .disposed(by: disposeBag)
    }
    
    public func add(data: BookmarkRequestDTO)-> Result<Int,Error> {
        switch database.add(data.toEntity()) {
        case .success():
            return .success(readLatestData().id)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    public func read()-> [BookmarkResponseDTO] {
        return database.read().map { $0.toDTO() }
    }
    
    public func readLatestData()-> BookmarkEntity {
        return database.read().last!
    }
}
