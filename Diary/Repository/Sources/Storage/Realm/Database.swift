//
//  Storeable.swift
//  Repository
//
//  Created by cheonsong on 2022/09/14.
//

import Foundation
import RealmSwift
import RxSwift

struct Database<Q: Object> {
    
    let disposeBag = DisposeBag()

    private var realm: Realm?
    
    public let changeSet = PublishSubject<[Q]>()
    
    init() {
        self.realm = try! Realm()
    }

    func add(_ object: Q)-> Result<Void,Error> {
        do {
            try realm?.write {
                realm?.add(object)
            }
            changeSet.onNext(Array(read()))
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func delete(_ object: Q)-> Result<Void,Error> {
        do {
            try realm?.write {
                realm?.delete(object)
            }
            changeSet.onNext(Array(read()))
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    private func read()-> Results<Q> {
        let objects = realm!.objects(Q.self)

        return objects
    }

}
