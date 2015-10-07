//
//  addPropertyTableViewCell.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class addPropertyTableViewCell: UITableViewCell, SBPickerSelectorDelegate {

    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var venueTitle: UITextField!
    @IBOutlet weak var parkingCapacity: UITextField!
    @IBOutlet weak var coveredArea: UITextField!
    @IBOutlet weak var propertyCapacity: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var venueType: UITextField!
    @IBOutlet weak var rooms: UITextField!
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var mobile: UITextField!
    
    var pickerSelectValue = ""
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
