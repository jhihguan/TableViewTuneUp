//
//  VCTableDelegate.swift
//  SlimTableView
//
//  Created by Wane Wang on 2015/11/15.
//  Copyright © 2015年 Wane Wang. All rights reserved.
//

import UIKit

class VCTableDelegate: UIControl, UITableViewDelegate {
    
    var datas = [VCTableCellData]()
    // readonly
    private(set) var selectedData = VCTableCellData?()
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let tableCell = cell as? TableCell {
            tableCell.setupData(self.datas[indexPath.row])
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedData = self.datas[indexPath.row]
        self.sendActionsForControlEvents(.ValueChanged)
    }
}
