//
//  Storeable.swift
//  Repository
//
//  Created by cheonsong on 2022/09/14.
//

import Foundation
import RealmSwift
import RxSwift
import Util

struct Database<Q: Object> {
    
    let disposeBag = DisposeBag()

    private var realm: Realm?
    
    public let dbCount = PublishSubject<Int>()
    
    init() {
        self.realm = try! Realm()
    }

    func add(_ object: Q)-> Result<Q,Error> {
        do {
            try realm?.write {
                realm?.add(object)
            }
            dbCount.onNext(read().count)
            return .success(object)
        } catch {
            return .failure(error)
        }
    }
    
    func update(_ object: Q)-> Result<Q, Error> {
        do {
            try realm?.write {
                realm?.add(object, update: .modified)
            }
            return .success(object)
        } catch {
            return .failure(error)
        }
    }

    func delete(_ object: Q)-> Result<Void,Error> {
        do {
            try realm?.write {
                realm?.delete(object)
            }
            dbCount.onNext(read().count)
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func deleteAll()-> Result<Void, Error> {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
            dbCount.onNext(0)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func read()-> Results<Q> {
        let objects = realm!.objects(Q.self)

        return objects
    }
    
    func readWithQuery(query: (Query<Q>)-> Query<Bool>)-> Results<Q> {
        let objects = realm!.objects(Q.self).where(query)
        
        return objects
    }

}
