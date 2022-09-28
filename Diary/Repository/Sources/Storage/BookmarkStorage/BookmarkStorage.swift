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
    
    private var bookmarkCount: Int
    
    public init() {
        bookmarkCount = database.read().count
        
        database.dbCount.subscribe(onNext: { [weak self] count in
            guard let self = self else { return }
            
            self.bookmarkCount = count
        })
        .disposed(by: disposeBag)
    }
    
    /// 북마크를 추가하는 함수, 추가 성공 시 ID값 리턴
    /// - Parameter data: BookmarkAddRequestDTO
    /// - Returns Result<Int, Error>
    public func add(data: BookmarkAddRequestDTO)-> Result<Int,Error> {
        let entity = data.toEntity()
        entity.id = bookmarkCount + 1
        
        switch database.add(entity) {
        case .success():
            return .success(readLatestData().id)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func readLatestData()-> BookmarkEntity {
        return database.read().last!
    }
    
    /// 북마크리스트를 불러오는 함수
    /// - Parameter dto: BookmarkFetchDTO (query, page)
    /// - Returns [BookmarkResponseDTO]
    public func read(_ dto: BookmarkFetchDTO)-> [BookmarkResponseDTO] {
        var data: [BookmarkEntity]!
        // Query유무에 따른 함수 실행
        if dto.query.isEmpty {
            data = Array(database.read())
        } else {
            data = Array(database.readWithQuery(query: dto.query))
        }
        data.reverse()
        // 페이지가 0이라면 페이징 처리하지 않고 리턴
        if dto.page == 0 {
            return data.map { $0.toDTO() }
        }
        // 페이징 처리 10개 단위로
        let start = (dto.page - 1) * 10
        let end = dto.page * 10
        return data[start..<end].map { $0.toDTO() }
    }
}

