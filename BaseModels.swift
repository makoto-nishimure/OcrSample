//
//  BaseModels.swift
//  StackViewSample
//
//  Created by makoto on 2021/02/13.
//

import Foundation
import RealmSwift

class BaseModels: RealmSwift.Object {
    @objc dynamic var id = -1
    @objc dynamic var createdAt = Date()
    @objc dynamic var updatedAt = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func getId() -> Int{
        return id
    }
    
    func getCreateAt() -> Date {
        return createdAt
    }
    
    func getUpdateAt() -> Date {
        return updatedAt
    }
}
