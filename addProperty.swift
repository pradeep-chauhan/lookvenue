//
//  addProperty.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class addProperty: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var propertyArray : NSMutableArray = NSMutableArray()
    var selectedPropertyDetailsArray : NSMutableArray = NSMutableArray()
    var editPropertyArray : NSMutableArray = NSMutableArray()
    var LoginDetails: loginDetails = loginDetails()
    var propertyInfo: NSDictionary = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerNib( a, forCellReuseIdentifier: "ScrollTableViewCell")
        self.tableView.registerNib(UINib(nibName: "addPropertyTableViewCell", bundle: nil), forCellReuseIdentifier: "addPropertyTableViewCell")
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //println("total edit: \(editPropertyArray.count)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //==
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 700
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("addPropertyTableViewCell") as! addPropertyTableViewCell
        
        //println(editPropertyArray[0])
        if(editPropertyArray.count > 0) {
            cell.email.text = editPropertyArray[0]["email"] as! NSString as String
            cell.venueTitle.text = editPropertyArray[0]["name"] as! NSString as String
            cell.address.text = (editPropertyArray[0]["area_id"] as! NSNumber).stringValue
            cell.propertyCapacity.text = (editPropertyArray[0]["capacity"] as! NSNumber).stringValue
            cell.city.text = (editPropertyArray[0]["city_id"] as! NSNumber).stringValue
            cell.area.text = (editPropertyArray[0]["area_id"] as! NSNumber).stringValue
            //cell.coveredArea.text = (selectedPropertyDetailsArray[0]["covered_area"] as! NSNumber).stringValue
            cell.desc.text = editPropertyArray[0]["description"] as! NSString as String
            cell.mobile.text = editPropertyArray[0]["mobile_number"] as! NSString as String
            cell.parkingCapacity.text = (editPropertyArray[0]["parking"] as! NSNumber).stringValue
            cell.priceRange.text = (editPropertyArray[0]["price_range_id"] as! NSNumber).stringValue
            cell.venueType.text = (editPropertyArray[0]["property_type_id"] as! NSNumber).stringValue
            //cell.rooms.text = (selectedPropertyDetailsArray[0]["rooms"] as! NSNumber).stringValue
            cell.website.text = (editPropertyArray[0]["website"] as! NSString as String)
            cell.zipcode.text = (editPropertyArray[0]["zipcode"] as! NSString as String)
            cell.state.text = (editPropertyArray[0]["state_id"] as! NSNumber).stringValue
        }
        else {
            //println(" got it empty result u can do any thing")
            cell.email.text = ""
            cell.venueTitle.text = ""
            cell.address.text = ""
            cell.propertyCapacity.text = ""
            cell.city.text = ""
            cell.area.text = ""
            cell.coveredArea.text = ""
            cell.desc.text = ""
            cell.mobile.text = ""
            cell.parkingCapacity.text = ""
            cell.priceRange.text = ""
            cell.venueType.text = ""
            cell.rooms.text = ""
            cell.website.text = ""
            cell.zipcode.text = ""
            cell.state.text = ""
        }
        
        cell.addPropertyButton.addTarget(self, action: ":savePropertyInfo", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    
    func savePropertyInfo() {
        println("add property")
        var indexPath = NSIndexPath(forItem: 0, inSection: 0)
        var row = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?
        var cell = tableView.dequeueReusableCellWithIdentifier("addPropertyTableViewCell") as! addNewPropertyViewController
        
        //var email = cell.
        
        
    }
    
    
//    func SACalendar(calendar: SaCalendar!, didDisplayCalendarForMonth month: Int32, year: Int32) {
//        println("done")
//    }
//    func SACalendar2(calendar1: SACalendar, didSelectDate day: Int32, month: Int32, year: Int32) {
////        prnit(day)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
