//
//  BaseDao.swift
//  StackViewSample
//
//  Created by makoto on 2021/02/13.
//

import Foundation
import RealmSwift

// T は BaseModels を継承したクラス。
class BaseDao <T : BaseModels> {
    let realm: Realm

    init() {
        // try! はエラーが発生するとクラッシュする。エラーが起こりえない場合に使うらしい。
        realm = try! Realm()
    }

    func get(key: Int) -> T? {
        print(String(describing: self))
        print(#function)

        return realm.object(ofType: T.self, forPrimaryKey: key)
    }

    func getAll() -> Results<T> {
        return realm.objects(T.self)
    }

    func create(d: T, createFunc:(_ d: T) -> (T)) -> Int {
        print(#file)
        print(#function)
        var id: Int = -1

        do {
            try realm.write {
                var obj = setDefaultColumnValue(d: d)
                id = obj.id
                obj = createFunc(obj)
                realm.add(obj)
            }
            return id
        } catch let err as NSError {
            print("create failed.")
            print(err.description)
        }
        return -1
    }

    func update(d: T) -> Bool {
        do {
            try realm.write {
                d.updatedAt = Date()
                realm.add(d, update: .all)
            }
            return true
        } catch let err as NSError {
            print("create failed.")
            print(err.description)
        }
        return false
    }

    func delete(d: T) {
        do {
            try realm.write {
                realm.delete(d)
            }
        } catch let err as NSError {
            print("delete failed.")
            print(err.description)
        }
    }

    func deleteAll() {
        // getAll で置き換え可能?
        let objs = realm.objects(T.self)
        do {
            try realm.write {
                realm.delete(objs)
            }
        } catch let err as NSError {
            print("deleteAll failed.")
            print(err.description)
        }
    }
    
    private func newId() -> Int? {
        print(#file)
        print(#function)

        guard let key = T.primaryKey() else {
            // primaryKey未設定
            return nil
        }

        // last が取得できた場合、変数 last を使って lastId を取得する。
        // last が取得できない、または lastId が取得できなかった場合は else。
        if let last = realm.objects(T.self).last,
           let lastId = last[key] as? Int {
            return lastId + 1
        } else {
            return 1
        }
    }

    private func setDefaultColumnValue(d: T) -> (T) {
        print(#file)
        print(#function)

        let date = Date()
        
        if realm.isInWriteTransaction {
            if d.id <= 0 {
                d.id = self.newId()!
            }
        } else {
            try! realm.write {
                if d.id <= 0 {
                    d.id = self.newId()!
                }
            }
        }

        d.createdAt = date
        d.updatedAt = date

        return d
    }
}
