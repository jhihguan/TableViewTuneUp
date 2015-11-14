//
//  ViewController.swift
//  FatTableView
//
//  Created by Wane Wang on 2015/11/14.
//  Copyright © 2015年 Wane Wang. All rights reserved.
//

import UIKit

class VCTable: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let kURL = "http://1sonplaceholder.typicode.com/photos"
    var refresh = UIRefreshControl()
    var datas = [VCTableCellData]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fat Table View Example"
        
        self.registerCell()
        self.setupPullToRefresh()
        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private
    private func registerCell() {
        let nibName = UINib(nibName: "TableCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: TableCell.classString())
    }
    
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
        self.tableView.addSubview(self.refresh)
        self.refresh.beginRefreshing()
    }
    
    // MARK: - Data
    
    @objc private func reloadData() {
        
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(NSURL(string: kURL)!) { (data, response, error) -> Void in
            if (error != nil) {
                self.showAlert("Oooooops..", message: "An Error Occured\n\(error!.localizedDescription)")
            }
            do {
                if let realData = data,
                    let json = try NSJSONSerialization.JSONObjectWithData( realData, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                    self.datas = json.flatMap { data in
                        return VCTableCellData.initWithDictionary(data)
                    }
                }
            } catch {
                self.showAlert("Oooooops..", message: "Error Response")
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.refresh.endRefreshing()
                self.tableView.reloadData()
            }
        }
        task.resume()
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(TableCell.classString(), forIndexPath: indexPath) as? TableCell
            else {
            fatalError("tableView should dequeue TableCell")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.datas.count > 10 {
            return 10
        } else {
            return self.datas.count
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let tableCell = cell as? TableCell {
            tableCell.setupData(self.datas[indexPath.row])
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let data = self.datas[indexPath.row]
        self.showAlert(self.title, message: "Selected ID: \(data.dataId)")
    }
}

