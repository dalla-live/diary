//
//  BookmarkFetchDTO.swift
//  Repository
//
//  Created by cheonsong on 2022/09/27.
//

import Foundation
import Domain
import RealmSwift

public struct BookmarkFetchDTO {
    let query: BookmarkQuery
    let page: Int
    
    public init(query: BookmarkQuery, page: Int) {
        self.query = query
        self.page = page
    }
}

extension BookmarkQuery {
    var query: (Query<BookmarkEntity>)-> Query<Bool> {
        switch self {
        case .all:
            return { $0 == $0 }
        case .month(let string):
            return { $0.date.contains(string) }
        case .id(let id):
            return { $0.id == id }
        case .location(let min, let max):
            return {
                ($0.lat > min.latitude && $0.lat < max.latitude) && ($0.lon > min.longitude && $0.lon < max.longitude)
            }
        }
    }
}
