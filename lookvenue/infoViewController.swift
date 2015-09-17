//
//  infoViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/4/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class infoViewController: UIViewController, CLUploaderDelegate {

    
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
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var totalImages: NSMutableArray = NSMutableArray()
    var displayImagesUrl: NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cloudinary.config().setValue("dtpcuqqq2", forKey: "cloud_name")
        cloudinary.config().setValue("897166688766548", forKey: "api_key")
        cloudinary.config().setValue("HZ3xp9PcVYWyaUaNB8yivz9FX8E", forKey: "api_secret")
        
        var transformation: CLTransformation = CLTransformation.transformation() as AnyObject as! CLTransformation
        transformation.setWidthWithInt(300)
        transformation.setHeightWithInt(300)
        
        //var imageArray:[UIImage] = []
        //var url = []
        //var urlString:String!
        if((totalImages.count) > 0) {
            for(var i = 0; i < totalImages.count; i++) {
                var cloudinary_image_id:String = (totalImages[i]["cloudinary_image_id"]) as! NSString as String
                var cloudinaryUrl:String = cloudinary.url(cloudinary_image_id as String)
                var url = NSURL(string: cloudinaryUrl)
                println(url)
                displayImagesUrl.addObject(url!)
                println(displayImagesUrl)
                images.sd_setImageWithURL(url, placeholderImage: UIImage(named: "nophoto.jpg"))
            }
            
        }
        
        
        // Adding scroll bar
        self.scrollView.contentSize=CGSize(width:0, height: 800);
        self.scrollView.showsVerticalScrollIndicator = true
         view.addSubview(scrollView)
         //println(selectedSearchVanueDictionary.valueForKey("name") as! NSString)
        
        
        // Do any additional setup after loading the view.
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
