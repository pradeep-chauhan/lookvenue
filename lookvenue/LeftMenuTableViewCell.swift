//
//  LeftMenuTableViewCell.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/29/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var MenuImage: UIImageView!
    @IBOutlet weak var MenuType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
