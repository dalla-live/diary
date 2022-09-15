//
//  Storeable.swift
//  Repository
//
//  Created by cheonsong on 2022/09/14.
//

import Foundation
import RealmSwift

struct DBManager<Q: Object> {

    private var realm: Realm?
    
    init() {
        self.realm = try! Realm()
    }

    public func add(_ object: Q) {
        try! realm?.write {
            realm?.add(object)
        }
    }

    public func delete(_ object: Q) {
        try! realm?.write {
            realm?.delete(object)
        }
    }

    public func read()-> Results<Q> {
        let objects = realm!.objects(Q.self)

        return objects
    }

}
