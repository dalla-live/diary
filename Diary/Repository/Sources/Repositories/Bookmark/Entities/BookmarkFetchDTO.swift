//
//  BookmarkFetchDTO.swift
//  Repository
//
//  Created by cheonsong on 2022/09/27.
//

import Foundation
import Domain

public struct BookmarkFetchDTO {
    let query: String
    let page: Int
    
    public init(query: String, page: Int) {
        self.query = query
        self.page = page
    }
}

extension BookmarkQuery {
    var query: String {
        switch self {
        case .all:
            return ""
        case .month(let date):
            return getMonth(date: date)
        case .id(let int):
            return "id == \(int)"
        case .location(_):
            return ""
        }
    }
}


func getMonth(date: String)-> String {
    let split = date.split(separator: ".")
    return String(split[safe: 2] ?? "")
}
