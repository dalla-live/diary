//
//  BookmarkStorage.swift
//  Repository
//
//  Created by cheonsong on 2022/09/23.
//

import Foundation
import RxSwift
import Domain

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
//        deleteAll()
    }
    
    /// 북마크를 추가하는 함수, 추가 성공 시 ID값 리턴
    /// - Parameter data: BookmarkAddRequestDTO
    /// - Returns Result<Int, Error>
    public func add(data: BookmarkDTO)-> Result<BookmarkDTO,Error> {
        let entity = data.toEntity()
//        guard let id = read(.init(query: .all, page: 0)).bookmarks.last?.id else {
//            return .failure(Error.self as! Error)
//        }
        
        if let id = read(.init(query: .all, page: 0)).bookmarks.last?.id {
            entity.id = id + 1
        } else {
            entity.id = 1
        }
        
        switch database.add(entity) {
        case .success(let entity):
            return .success(entity.toDTO())
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /// 북마크를 업데이트하는 함수, 업데이트 성공 시 성공한 Bookmark Return
    /// - Parameter data: BookmarkAddDTO
    /// - Returns Result<BookmarkDTO, Error>
    public func update(data: BookmarkDTO)-> Result<BookmarkDTO, Error> {
        switch database.update(data.toEntity()) {
        case .success(let entity):
            return .success(entity.toDTO())
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /// 북마크리스트를 불러오는 함수
    /// - Parameter dto: BookmarkFetchDTO (query, page)
    /// - Returns [BookmarkResponseDTO]
    public func read(_ dto: BookmarkFetchDTO)-> BookmarkResponseDTO {
        var data: [BookmarkEntity] = []
        
        // Query유무에 따른 함수 실행
        switch dto.query {
        case .all:
            data = Array(database.read())
            
            // 페이지가 0이라면 페이징 처리하지 않고 리턴
            if dto.page == 0 {
                let dto = data.map { $0.toDTO() }
                return BookmarkResponseDTO(bookmarks: dto, hasNext: false)
            }
            
            // 페이징 처리 10개 단위로
            data.reverse()
            let start = (dto.page - 1) * 10
            // 페이지 요청이 최대 페이지를 넘어선 경우 빈배열 반환
            if start > bookmarkCount {
                return BookmarkResponseDTO(bookmarks: [], hasNext: false)
            }
            
            let end = min(dto.page * 10, bookmarkCount) // 해당 페이지가 10개가 되지 않는 경우 예외 처리
            let dtos = data[start..<end].map { $0.toDTO() }
            
            return BookmarkResponseDTO(bookmarks: dtos, hasNext: end != bookmarkCount)
            
        default:
            data = Array(database.readWithQuery(query: dto.query.query))
            return BookmarkResponseDTO(bookmarks: data.map { $0.toDTO() }, hasNext: false)
        }
    }
    
    /// 북마크를 삭제하는 함수
    /// - Parameter dto: BookmarkDTO
    /// - Returns Result<Void, Error>
    func delete(_ dto: BookmarkDTO)-> Result<Void, Error> {
        
        let entity = database.readWithQuery(query: BookmarkQuery.id(dto.id).query).first!
        
        switch database.delete(entity) {
        case .success():
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /// 데이터 전체 삭제
    func deleteAll()-> Result<Void, Error> {
        switch database.deleteAll() {
        case.success():
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
}

