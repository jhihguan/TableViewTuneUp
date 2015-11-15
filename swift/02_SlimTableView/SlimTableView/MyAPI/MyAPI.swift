//
//  MyAPI.swift
//  SlimTableView
//
//  Created by Wane Wang on 2015/11/15.
//  Copyright © 2015年 Wane Wang. All rights reserved.
//

import Foundation

class MyAPI {
    let kURL = "http://jsonplaceholder.typicode.com/photos"
    
    internal func getPhotos(closure: ([[String: AnyObject]], NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(NSURL(string: kURL)!) { (data, response, error) -> Void in
            var datas = [[String: AnyObject]]()
            var resultError: NSError?
            if (error != nil) {
                resultError = error
            }
            do {
                if let realData = data,
                    let json = try NSJSONSerialization.JSONObjectWithData( realData, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]] {
                        datas = json
                }
            } catch let caught as NSError {
                resultError = caught
            }
            closure(datas, resultError)
        }
        task.resume()
        
        
    }
}