//
//  VCTableDataSource.swift
//  SlimTableView
//
//  Created by Wane Wang on 2015/11/15.
//  Copyright © 2015年 Wane Wang. All rights reserved.
//

import UIKit

class VCTableDataSource: NSObject, UITableViewDataSource {
    var datas = [VCTableCellData]()
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(TableCell.classString(), forIndexPath: indexPath) as? TableCell
            else {
                fatalError("tableView should dequeue TableCell")
        }
        return cell
    }
}
