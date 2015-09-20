//
//  infoViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/4/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit
let reuseIdentifierImage = "ImageCellIdentifier"
class infoViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, CLUploaderDelegate {

    
    var selectedSearchVanueDictionary = NSDictionary()
    let cloudinary: CLCloudinary = CLCloudinary()
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var rooms: UILabel!
    @IBOutlet weak var parkingCapacity: UILabel!
    @IBOutlet weak var coverdArea: UILabel!
    @IBOutlet weak var propertyCapacity: UILabel!
    @IBOutlet weak var venueType: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var totalImages: NSMutableArray = NSMutableArray()
    var displayImagesUrl: NSMutableArray = NSMutableArray()
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        cloudinary.config().setValue("dtpcuqqq2", forKey: "cloud_name")
        cloudinary.config().setValue("897166688766548", forKey: "api_key")
        cloudinary.config().setValue("HZ3xp9PcVYWyaUaNB8yivz9FX8E", forKey: "api_secret")
        
        var transformation: CLTransformation = CLTransformation.transformation() as AnyObject as! CLTransformation
        transformation.setWidthWithInt(300)
        transformation.setHeightWithInt(300)
        
        
        // Adding scroll bar
        self.scrollView.contentSize=CGSize(width: 0, height: 800);
        self.scrollView.showsVerticalScrollIndicator = true
         view.addSubview(scrollView)
         //println(selectedSearchVanueDictionary.valueForKey("name") as! NSString)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return totalImages.count
        
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width:imageCollectionView.frame.width, height: 300)
            
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierImage, forIndexPath: indexPath) as! PropertyImageCollectionViewCell
            var cloudinary_image_id:String = (totalImages[indexPath.row]["cloudinary_image_id"]) as! NSString as String
            var cloudinaryUrl:String = cloudinary.url(cloudinary_image_id as String)
            var url = NSURL(string: cloudinaryUrl)
            println(url)
            displayImagesUrl.addObject(url!)
            println(displayImagesUrl)
            cell.images.sd_setImageWithURL(url, placeholderImage: UIImage(named: "nophoto.jpg"))
            var currentImage = ((indexPath.row) + 1)
            var totalImageCount = (totalImages.count)
            println(" \(currentImage) / \(totalImageCount) ")
            cell.slideNo.text = " \(currentImage) / \(totalImageCount) "
        return cell
        // Configure the cell+
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
