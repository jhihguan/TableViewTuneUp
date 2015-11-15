//
//  VCTableCoordinator.swift
//  SlimTableView
//
//  Created by Wane Wang on 2015/11/15.
//  Copyright © 2015年 Wane Wang. All rights reserved.
//

import UIKit

class VCTableCoordinator: NSObject {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataSource: VCTableDataSource!
    @IBOutlet weak var delegate: VCTableDelegate!
    
    var datas = [VCTableCellData]()
    
    func reloadData(dataArray: [VCTableCellData]) {
        self.delegate.datas = dataArray
        self.dataSource.datas = dataArray
        
        self.tableView.reloadData()
    }
    
    func registerCell() {
        let nibName = UINib(nibName: "TableCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: TableCell.classString())
    }
}
