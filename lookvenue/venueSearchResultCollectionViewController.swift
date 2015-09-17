//
//  venueSearchResultCollectionViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/2/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

let reuseIdentifier = "CellIdentifier"
class venueSearchResultCollectionViewController: UICollectionViewController,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, CLUploaderDelegate {
    
    var searchVenueListArray : NSArray!
    var searchVenuesArray : NSMutableArray = NSMutableArray()
    
    let cloudinary: CLCloudinary = CLCloudinary()
    var image:NSString = ""
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getSearchVenueArray()
        
        
        cloudinary.config().setValue("dtpcuqqq2", forKey: "cloud_name")
        cloudinary.config().setValue("897166688766548", forKey: "api_key")
        cloudinary.config().setValue("HZ3xp9PcVYWyaUaNB8yivz9FX8E", forKey: "api_secret")
        
        var transformation: CLTransformation = CLTransformation.transformation() as AnyObject as! CLTransformation
        transformation.setWidthWithInt(300)
        transformation.setHeightWithInt(300)
        //transformation.setCrop("fit")
        //var abc:String = cloudinary.url(image as String)
        
        //println(abc)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSearchVenueArray() -> Void
    {
        var searchVenue : SearchVenue = SearchVenue()
        searchVenuesArray = searchVenueListArray as! NSMutableArray
        
        
    }


    // MARK: UICollectionViewDataSource

//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return
//    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return searchVenueListArray.count
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
            //var image = ""
            var imageCount: Array = (searchVenuesArray[indexPath.row]["images"] as! NSArray) as Array
            var first_cloudinary_image_id:NSString!
            if((imageCount.count) > 0) {
                first_cloudinary_image_id = (imageCount[0]["cloudinary_image_id"] as! NSString) as String
            }
            var cloudinaryUrl:String = cloudinary.url(first_cloudinary_image_id as String)
            var url = NSURL(string: cloudinaryUrl)
            //println(url!)
            cell.venueImages.sd_setImageWithURL(url!, placeholderImage: UIImage(named: "nophoto.jpg"))
        
            var address:String = ((searchVenuesArray[indexPath.row]["area"] as! NSString as String) + "," + (searchVenuesArray[indexPath.row]["city"] as! NSString as String) + "," + (searchVenuesArray[indexPath.row]["state"] as! NSString as String))
            cell.title.text = searchVenuesArray[indexPath.row]["name"] as! NSString as String
            cell.addressLine.text = searchVenuesArray[indexPath.row]["address_line_1"] as! NSString as String
            var capacityValue:String = (searchVenuesArray[indexPath.row]["capacity"] as! NSNumber).stringValue
            cell.capacity.text = capacityValue + "(PAX)"
            cell.priceRange.text = searchVenuesArray[indexPath.row]["price_range"] as! NSString as String
            cell.address.text = address
            cell.zipcode.text = searchVenuesArray[indexPath.row]["zipcode"] as! NSString as String
            return cell
        // Configure the cell
        
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width:(self.collectionView!.frame.width) - 20.0, height: 380)
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var dash : propertyViewController = storyBoard.instantiateViewControllerWithIdentifier("propertyView") as! propertyViewController
        println(indexPath.row)
        dash.selectedSearchVanueDictionary = self.searchVenueListArray.objectAtIndex(indexPath.row) as! NSDictionary
        self.navigationController?.pushViewController(dash, animated: true)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
    
    }
    */

}
