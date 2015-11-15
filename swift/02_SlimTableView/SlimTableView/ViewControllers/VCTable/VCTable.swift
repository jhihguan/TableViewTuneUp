//
//  ViewController.swift
//  SlimTableView
//
//  Created by Wane Wang on 2015/11/14.
//  Copyright © 2015年 Wane Wang. All rights reserved.
//

import UIKit

class VCTable: UIViewController {
    
    @IBOutlet var tableCoordinator: VCTableCoordinator!
    
    let refresh = UIRefreshControl()
    let api = MyAPI()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fat Table View Example"
        self.tableCoordinator.registerCell()
        self.setupPullToRefresh()
        self.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    private func showAlert(title: String?, message: String? ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
        alertController.addAction(cancelAction)
        dispatch_async(dispatch_get_main_queue()) {
            self.view.window?.rootViewController?.presentViewController(alertController, animated: true, completion: { () -> Void in
                
            })
        }
    }
    
    // MARK: - Pull to refresh
    
    private func setupPullToRefresh() {
        self.refresh.addTarget(self, action: "reloadData", forControlEvents: .ValueChanged)
        self.tableCoordinator.tableView.addSubview(self.refresh)
        self.refresh.beginRefreshing()
    }
    
    // MARK: - Data
    
    @objc private func reloadData() {
        self.api.getPhotos { (datas, error) -> Void in
            if (error != nil) {
                self.showAlert("Oooooops..", message: "An Error Occured\n\(error!.localizedDescription)")
            }
            let photoDatas = datas.flatMap { data in
                return VCTableCellData.initWithDictionary(data)
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.refresh.endRefreshing()
                self.tableCoordinator.reloadData(photoDatas)
            }
        }
        
        
    }
    
    @IBAction func itemPressed(sender: VCTableDelegate) {
        if let data = sender.selectedData {
            self.showAlert(self.title, message: "Selected ID: \(data.dataId)")
        }
    }
    
    
}

