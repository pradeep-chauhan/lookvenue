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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(propertyArray)
        //self.tableView.registerNib( a, forCellReuseIdentifier: "ScrollTableViewCell")
        self.tableView.registerNib(UINib(nibName: "addPropertyTableViewCell", bundle: nil), forCellReuseIdentifier: "addPropertyTableViewCell")
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.delegate = self
        self.tableView.dataSource = self

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
        println(propertyArray[indexPath.row])
        cell.email.text = propertyArray[indexPath.row]["email"] as! NSString as String
        cell.venueTitle.text = propertyArray[indexPath.row]["name"] as! NSString as String
        cell.address.text = propertyArray[indexPath.row]["area_id"] as! NSString as String
        cell.propertyCapacity.text = propertyArray[indexPath.row]["capacity"] as! NSString as String
        cell.city.text = propertyArray[indexPath.row]["city_id"] as! NSString as String
        cell.venueTitle.text = propertyArray[indexPath.row]["name"] as! NSString as String
        cell.coveredArea.text = propertyArray[indexPath.row]["covered_area"] as! NSString as String
        cell.desc.text = propertyArray[indexPath.row]["description"] as! NSString as String
        cell.mobile.text = propertyArray[indexPath.row]["mobile_number"] as! NSString as String
        cell.parkingCapacity.text = propertyArray[indexPath.row]["parking"] as! NSString as String
        cell.priceRange.text = propertyArray[indexPath.row]["price_range_id"] as! NSString as String
        cell.venueType.text = propertyArray[indexPath.row]["property_type_id"] as! NSString as String
        cell.desc.text = propertyArray[indexPath.row]["description"] as! NSString as String
        cell.rooms.text = propertyArray[indexPath.row]["rooms"] as! NSString as String
        cell.website.text = propertyArray[indexPath.row]["website"] as! NSString as String
        cell.zipcode.text = propertyArray[indexPath.row]["zipcode"] as! NSString as String
        cell.state.text = propertyArray[indexPath.row]["state_id"] as! NSString as String
        
        return cell
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
