//
//  DashBoardTableViewCell.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/5/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class DashBoardTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var propertyName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
