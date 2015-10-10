//
//  propertyViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/4/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class propertyViewController: UIViewController, CLUploaderDelegate, UITabBarDelegate {

    @IBOutlet weak var containerView: UIView!
    //@IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var information : infoViewController = infoViewController()
    var location : locationViewController = locationViewController()
    
    @IBOutlet weak var mainTabBar: UITabBar!
    // cloudinary setup
    
    var selectedSearchVanueDictionary = NSDictionary()
    
    var name:String!
    var website:String!
    var Description:String!
    var priceRange:String!
    var rooms:String!
    var parkingCapacity:String!
    var coverdArea:String!
    var propertyCapacity:String!
    var venueType:String!
    var address:String!
    var area:String!
    var city:String!
    var state:String!
    var zipcode:String!
    var lat:Double!
    var long:Double!
    var images: NSMutableArray!
    var phone:String!
    var email:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTabBar.delegate = self
        
        self.mainTabBar.barTintColor = UIColor(red: 210.0/255.0, green: 67.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        phone = selectedSearchVanueDictionary.valueForKey("mobile_number") as! NSString as String
        email = selectedSearchVanueDictionary.valueForKey("email") as! NSString as String
        name = selectedSearchVanueDictionary.valueForKey("name") as! NSString as String
        website = selectedSearchVanueDictionary.valueForKey("website") as! NSString as String
        Description = selectedSearchVanueDictionary.valueForKey("description") as! NSString as String
        priceRange = selectedSearchVanueDictionary.valueForKey("price_range") as! NSString as String
        //rooms = (selectedSearchVanueDictionary.valueForKey("rooms") as! NSNumber).stringValue
        parkingCapacity = (selectedSearchVanueDictionary.valueForKey("parking") as! NSNumber).stringValue
        coverdArea = (selectedSearchVanueDictionary.valueForKey("covered_area") as! NSNumber).stringValue
        propertyCapacity = (selectedSearchVanueDictionary.valueForKey("capacity") as! NSNumber).stringValue
        venueType = selectedSearchVanueDictionary.valueForKey("property_type") as! NSString as String
        address = selectedSearchVanueDictionary.valueForKey("address_line_1") as! NSString as String
        area = selectedSearchVanueDictionary.valueForKey("area") as! NSString as String
        city = selectedSearchVanueDictionary.valueForKey("city") as! NSString as String
        state = selectedSearchVanueDictionary.valueForKey("state") as! NSString as String
        zipcode = selectedSearchVanueDictionary.valueForKey("zipcode") as! NSString as String
        lat = (selectedSearchVanueDictionary.valueForKey("lat") as! NSString).doubleValue
        long = (selectedSearchVanueDictionary.valueForKey("lng") as! NSString).doubleValue
        images = (selectedSearchVanueDictionary.valueForKey("images")) as! NSMutableArray
        
        
        if(segmentControl.selectedSegmentIndex == 0)
        {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var information = storyBoard.instantiateViewControllerWithIdentifier("information") as! infoViewController
            
            information.totalImages = images
            
            information.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)
            self.containerView.addSubview(information.view)
            self.addChildViewController(information)
            information.name.text = name
            information.website.text = website
            information.Description.text = Description
            information.priceRange.text = priceRange
            information.rooms.text = rooms
            information.parkingCapacity.text = parkingCapacity
            information.coverdArea.text = coverdArea
            information.propertyCapacity.text = propertyCapacity
            information.venueType.text = venueType
            
            information.didMoveToParentViewController(self)
            
        }
        else if(segmentControl.selectedSegmentIndex == 1)
        {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var location = storyBoard.instantiateViewControllerWithIdentifier("locationView") as! locationViewController
            location.lat = lat
            location.lng = long
            location.markerTitle = name
            location.markerSubTitle = venueType
            location.view.frame = self.containerView.bounds
            self.containerView.addSubview(location.view)
            self.addChildViewController(location)
            
            location.address.text = address
            location.area.text = area
            location.city.text = city
            location.state.text = state
            location.zipcode.text = zipcode
            
            location.didMoveToParentViewController(self)
            
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if(item.tag == 0) {
            if(phone != nil) {
                UIApplication.sharedApplication().openURL(NSURL(string: "tel://" + phone)!)
            }
            else {
                let alert = UIAlertView()
                alert.title = "Sorry!"
                alert.message = "Phone number is not available for this business"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        else if(item.tag == 1) {
            if( email != nil) {
                 UIApplication.sharedApplication().openURL(NSURL(string: "mailto://" + email)!)
            }
            else {
                let alert = UIAlertView()
                alert.title = "Sorry!"
                alert.message = "Email is not available for this business"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        else {
            println("tab bar")
        }
    }
    
    @IBAction func segmentControlAction(sender: AnyObject) {
        
        if(segmentControl.selectedSegmentIndex == 0)
        {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var information = storyBoard.instantiateViewControllerWithIdentifier("information") as! infoViewController
            
            information.totalImages = images
            
            information.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)
            self.containerView.addSubview(information.view)
            self.addChildViewController(information)
            information.name.text = name
            information.website.text = website
            information.Description.text = Description
            information.priceRange.text = priceRange
            information.rooms.text = rooms
            information.parkingCapacity.text = parkingCapacity
            information.coverdArea.text = coverdArea
            information.propertyCapacity.text = propertyCapacity
            information.venueType.text = venueType
            information.didMoveToParentViewController(self)
            
        }
        else if(segmentControl.selectedSegmentIndex == 1)
        {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var location = storyBoard.instantiateViewControllerWithIdentifier("locationView") as! locationViewController
            location.lat = lat
            location.lng = long
            location.markerTitle = name
            location.markerSubTitle = venueType
            location.view.frame = self.containerView.bounds
            self.containerView.addSubview(location.view)
            self.addChildViewController(location)
            
            location.address.text = address
            location.area.text = area
            location.city.text = city
            location.state.text = state
            location.zipcode.text = zipcode

            location.didMoveToParentViewController(self)
        }
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
