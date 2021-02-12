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
        title = "memo"
    }

    let TODO = ["境界線上のホライゾン", "Heart of Lapis", "芥見下々"]
    let CTX = ["Horizon on the Middle of Nowhere", "ラピスの心臓", "呪術廻戦"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView: \(indexPath.row)")

        tableView.delegate = self
        tableView.rowHeight = 80

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath) as! TableCell
        cell.setData(title: TODO[indexPath.row], context: CTX[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped: \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

