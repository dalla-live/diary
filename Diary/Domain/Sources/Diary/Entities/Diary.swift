//
//  Diary.swift
//  Domain
//
//  Created by chuchu on 2022/09/15.
//

import Foundation
import RealmSwift

public class Diary: Object {
    public typealias Identifier = Int
    
    @objc dynamic var id: Identifier = 0
    @objc dynamic var contents: String = ""
    @objc dynamic var bookmark: Bookmark? = Bookmark()
    
    convenience init(id: Identifier, contents: String, bookmark: Bookmark) {
        self.init()
        self.id = id
        self.contents = contents
        self.bookmark = bookmark
    }
    
    // 기본키 설정
    public override class func primaryKey() -> String? {
        return "id"
    }
}

public struct DiaryList {
    let diaries: [Diary]
}
