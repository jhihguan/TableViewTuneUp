//
//  VCTableCellData.swift
//  FatTableView
//
//  Created by Wane Wang on 2015/11/14.
//  Copyright © 2015年 Wane Wang. All rights reserved.
//

import Foundation

struct VCTableCellData {
    var albumId: Int
    var dataId: Int
    var title: String
    var thumbnailUrl: String
    var url: String
    
    static func initWithDictionary(dict: [String: AnyObject]) -> VCTableCellData? {
        guard let albumId = dict["albumId"] as? Int,
            let dataId = dict["id"] as? Int,
            let title = dict["title"] as? String,
            let thumbnailUrl = dict["thumbnailUrl"] as? String,
            let url = dict["url"] as? String
            else {
                return nil
        }
        return VCTableCellData(albumId: albumId, dataId: dataId, title: title, thumbnailUrl: thumbnailUrl, url: url)
    }
}