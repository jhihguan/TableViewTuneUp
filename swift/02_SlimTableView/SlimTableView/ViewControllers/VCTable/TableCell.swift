//
//  TableCell.swift
//  FatTableView
//
//  Created by Wane Wang on 2015/11/14.
//  Copyright © 2015年 Wane Wang. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    
    class func classString() -> String {
        return NSStringFromClass(self)
    }
    
    func setupData(data: VCTableCellData) {
        self.cellTitle.text = "Entry ID: \(data.dataId)"
        if  let url = NSURL(string: data.url),
            let imageData = NSData(contentsOfURL: url) {
            self.cellImage.image = UIImage(data: imageData)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
