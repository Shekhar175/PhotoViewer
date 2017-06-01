//
//  CustomTableCell.swift
//  SDPhotoViewerDemo
//
//  Created by Shekhar on 5/31/17.
//  Copyright © 2017 perennial. All rights reserved.
//

import UIKit
import Foundation

class CustomTableCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layoutIfNeeded()
        self.layoutSubviews()
    }
}
