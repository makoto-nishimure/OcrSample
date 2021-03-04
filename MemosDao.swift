//
//  MemosDao.swift
//  StackViewSample
//
//  Created by makoto on 2021/02/13.
//

import Foundation

class MemosDao: BaseDao<Memos> {
    
    static let sharedInstance: MemosDao = MemosDao()
    private override init() {
        super.init()
        print("created sharedInstance MemosDao")
    }
    
    func create(title: String?, contents: String?) -> Int {
        print(String(describing: self))
        print(#function)
        
        print("title: \(title ?? "failed")")
        print("contents: \(contents ?? "failed")")

        
        let memo: Memos = Memos()
        
        let createFunc = {(memo: Memos) -> Memos in
            if let _title = title,
               let _contents = contents {
                memo.title = _title
                memo.contents = _contents
            }
            return memo
        }
        
        let id: Int = self.create(d: memo, createFunc: createFunc)
        print("id: \(id)")
        return id
    }
    
    func update(memo: Memos, title: String?, contents: String?) -> Bool {
        print(String(describing: self))
        print(#function)
        
        try! realm.write {
            memo.title = title!
            memo.contents = contents!
        }
        return self.update(d: memo)
    }
}
