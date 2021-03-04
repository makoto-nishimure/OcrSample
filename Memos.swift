//
//  Memos.swift
//  StackViewSample
//
//  Created by makoto on 2021/02/13.
//

import Foundation
import RealmSwift

class Memos: BaseModels {
    @objc dynamic var title: String = ""
    @objc dynamic var contents: String = ""
    
    func getTitle() -> String {
        return title
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func getContents() -> String {
        return contents
    }
    
    func setContents(contents: String) {
        self.contents = contents
    }

}
