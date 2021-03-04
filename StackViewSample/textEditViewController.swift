//
//  textEditController.swift
//  StackViewSample
//
//  Created by makoto on 2021/03/04.
//

import UIKit
import RealmSwift

class textEditViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var noteView: UITextView!
    
    var memo: Memos!
    let memosDao: MemosDao = MemosDao.sharedInstance
    
    override func viewDidLoad() {
        titleView.delegate = self
        noteView.delegate  = self
        
        titleView.text = memo.getTitle()
        titleView.font = UIFont.boldSystemFont(ofSize: 24)
        noteView.text  = memo.getContents()
        noteView.font  = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var title: String
        var note: String
        switch textView.tag {
        case 1:
            title = textView.text
            note  = memo.getContents()
        case 2:
            note  = textView.text
            title = memo.getTitle()
        default:
            print("Unexpected err: textViewDidChange")
            return
        }
        if (!memosDao.update(memo: memo, title: title, contents: note)) {
            print("realm write failed.")
            return
        }
    }
}
