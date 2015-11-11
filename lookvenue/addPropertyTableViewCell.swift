//
//  addPropertyTableViewCell.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class addPropertyTableViewCell: UITableViewCell {

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
    
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var priceRange: UITextField!
   
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var addPropertyButton: UIButton!
    var pickerSelectValue = ""
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addPropertyButton.layer.cornerRadius = 5
        self.addPropertyButton.backgroundColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)

        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
