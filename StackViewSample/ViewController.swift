//
//  ViewController.swift
//  StackViewSample
//
//  Created by makoto on 2021/02/06.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    let memosDao: MemosDao = MemosDao.sharedInstance
    var memos: Results<Memos>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "memo"
        memos = memosDao.getAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memos = memosDao.getAll()
        tableView.reloadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView: \(indexPath.row)")

        tableView.delegate = self
        tableView.rowHeight = 80

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath) as! TableCell
        let memo = memos[indexPath.row]
        cell.setData(title: memo.getTitle(), context: memo.getContents())
        
        print("id      : \(memo.getId())")
        print("createAt: \(memo.getCreateAt())")
        print("title   : \(memo.title)")
        print("contents: \(memo.contents)")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memo = memos[indexPath.row]
        print(memo.getTitle())
        print(memo.getContents())
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "toTextEdit", sender: memo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTextEdit" {
            let textEditView = segue.destination as! textEditViewController
            textEditView.memo = (sender as! Memos)
        }
    }

}

