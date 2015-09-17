//
//  CollectionViewCell.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/2/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var venueImages: UIImageView!
    
    @IBOutlet weak var zipcode: UILabel!
    @IBOutlet weak var addressLine: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var title: UILabel!
}
