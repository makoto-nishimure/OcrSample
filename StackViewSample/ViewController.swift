//
//  ViewController.swift
//  StackViewSample
//
//  Created by makoto on 2021/02/06.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    let TODO = ["境界線上のホライゾン", "Heart of Lapis", "芥見下々"]
    let CTX = ["Horizon on the Middle of Nowhere", "ラピスの心臓", "呪術廻戦"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView: \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath) as! TableCell
        tableView.rowHeight = 80
        cell.title?.text = TODO[indexPath.row]
        cell.context?.text = CTX[indexPath.row]
        return cell
    }
    



}

