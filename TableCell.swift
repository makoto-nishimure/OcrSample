//
//  TableCell.swift
//  StackViewSample
//
//  Created by makoto on 2021/02/11.
//

import UIKit

class TableCell:UITableViewCell {
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var context: UILabel!

    func setData(title: String, context: String) {
        self.title.text = title
        self.context.text = context
    }
}
