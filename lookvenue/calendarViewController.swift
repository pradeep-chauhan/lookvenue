//
//  calendarViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class calendarViewController: UIViewController, CKCalendarDelegate, SBPickerSelectorDelegate {
    
    @IBOutlet weak var changeCalendar: UIButton!
    @IBOutlet weak var bookingButton: UIButton!
    var minimumDate:NSDate = NSDate()
    var dateFormatter = NSDateFormatter()
    
    var chosenDates:NSMutableArray = NSMutableArray()
    var disabledDates:NSMutableArray = NSMutableArray()
    var selectedPropertyDetailsArray : NSMutableArray = NSMutableArray()
    var calendarDetailsListArray : NSArray!
    var calendarDetailsArray : NSMutableArray = NSMutableArray()
    var editPropertyArray : NSMutableArray = NSMutableArray()
    var LoginDetails: loginDetails = loginDetails()
    
    var monthStartDate:String!
    var monthEndDate:String!
    var currentDate = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        //**********************************//
        println("\(currentDate)")
        bookingButton.backgroundColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1)
        bookingButton.layer.cornerRadius = 5
        changeCalendar.backgroundColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1)
        changeCalendar.layer.cornerRadius = 5
        var calendar: CKCalendarView = CKCalendarView()
        calendar.delegate = self
        calendar.backgroundColor = UIColor.grayColor()
        calendar.onlyShowCurrentMonth = false;
        calendar.adaptHeightToNumberOfWeeksInMonth = false;
        calendar.frame = CGRectMake(0, 125, self.view.frame.width, self.view.frame.height);
        self.view.addSubview(calendar)
        self.dateFormatter = NSDateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        self.navigationItem.title = "Calendar"
        getBookingDetails(currentDate)
        
        // Do any additional setup after loading the view.
    }
    
    func getBookingDetails (date:NSDate) {
        
        self.returnDate(currentDate)
        let loadingProgress = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingProgress.labelText = "Loading"
        var authentication = ( self.LoginDetails.remember_token as NSString) as String
        var methodType: String = "GET"
        var base: String = "bookings?"
        
        var startDate = "\(monthStartDate)"
        var endDate = "\(monthEndDate)"
        var propertyId = (selectedPropertyDetailsArray[0]["id"] as! NSNumber).stringValue
        var param: String = "property_id=\(propertyId)&start_date=\(startDate)&end_date=\(endDate)"
        var urlRequest: String = base + param
        var serviceCall : WebServiceCall = WebServiceCall()
        serviceCall.adminApiCallRequest(methodType, urlRequest: urlRequest, param:[:], authentication: authentication, completion: { (resultData) -> () in
            self.calendarDetailsListArray = serviceCall.getCalendarDetailsArray(resultData)
            self.getCalendarDetailsArray()
            for ( var i = 0; i < self.calendarDetailsArray.count; i++) {
                var bookingDates = self.calendarDetailsArray[i]["status"]
                var flag = 1
                if ( bookingDates as! Int == flag ) {
                    self.disabledDates.addObject(self.calendarDetailsArray[i]["for_date"] as! NSString as String)
                    println("Disabled Date === \(self.disabledDates)")
                }
                
            }
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        })
    }
    
    
    func getCalendarDetailsArray () -> Void {
        
        calendarDetailsArray = calendarDetailsListArray as! NSMutableArray
    }

    @IBAction func changeCalendar(sender: AnyObject) {
        DatePickerDialog().show(title: "Select Month/Year", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            
            (date) -> Void in
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy"
            self.currentDate = date
            self.reloadInputViews()
            //self.dateOfEnquiry.resignFirstResponder()
        }
        
    }
    @IBAction func bookingUpdate(sender: AnyObject) {
        var allBookingDates:NSMutableArray = NSMutableArray()
        if( chosenDates.count > 0 ) {
            
            for ( var i = 0; i < chosenDates.count; i++ ) {
                
                allBookingDates.addObject(dateFormatter.stringFromDate(chosenDates[i] as! NSDate))
            }
            
            var authentication = NSUserDefaults.standardUserDefaults().objectForKey("remember_token") as! NSString
            var methodType: String = "PUT"
            var base: String = "bookings/bulk_update"
            var propertyId = (selectedPropertyDetailsArray[0]["id"] as! NSNumber).stringValue
            var urlRequest: String = base
            var serviceCall : WebServiceCall = WebServiceCall()
            var bulk_data : [String: AnyObject] = [:]
            bulk_data["for_dates"] = allBookingDates
            bulk_data["property_id"] = propertyId
            bulk_data["status"] = "true"
            
            var upload_data : [String: AnyObject] = [:]
            upload_data["bulk_data"] = bulk_data
            
            serviceCall.adminApiCallRequest(methodType, urlRequest: urlRequest, param:upload_data as Dictionary<String, AnyObject>, authentication: authentication as String, completion: { (resultData) -> () in
//                var result = serviceCall.bookingResult(resultData)
//                if ( result != "") {
//                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//                    let message = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//                    message.mode = MBProgressHUDMode.Text
//                    message.detailsLabelText = "Done Successfully"
//                    message.hide(true, afterDelay: 3)
//                }
//                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
            })
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dateIsDisabled(date: NSDate) -> Bool {
        //self.disabledDates.removeAllObjects()
        for ( var i = 0; i < self.disabledDates.count; i++) {
            
            if ( disabledDates[i].isEqual("\(dateFormatter.stringFromDate(date))")) {
                
                return true
            }
        }
        return false
    }
    
    
    func calendar(calendar: CKCalendarView!, configureDateItem dateItem: CKDateItem!, forDate date: NSDate!) {
  
        if (self.dateIsDisabled(date)) {
            dateItem.backgroundColor = UIColor.redColor()
            dateItem.textColor = UIColor.whiteColor()
        }
        
        if chosenDates.containsObject(date) {
            dateItem.backgroundColor = UIColor.greenColor()
            println("chosen date => \(chosenDates)")
        }
        
        
    }
    
    func calendar(calendar: CKCalendarView!, willSelectDate date: NSDate!) -> Bool {
//        var dateItem = CKDateItem()
//        if date.laterDate(minimumDate) == minimumDate {
//            dateItem.textColor = UIColor.grayColor()
//        }
//        return calendar.dateIsInCurrentMonth(date)
        return self.dateIsDisabled(date!)
    }
    
    func calendar(calendar: CKCalendarView!, willDeselectDate date: NSDate!) -> Bool {
        var dateItem = CKDateItem()
        dateItem.backgroundColor = UIColor.clearColor()
        chosenDates.removeObject(date)
        
        println("remove \(chosenDates)")
        return true
    }
    
    func calendar(calendar: CKCalendarView!, didSelectDate date: NSDate!) {
//        var selectedDate = CKDateItem()
//        selectedDate.backgroundColor = UIColor.blueColor()
        var Date = dateFormatter.stringFromDate(date)
        chosenDates.addObject(date)
        println("chosen date = \(chosenDates)")
        //println("selected date = \(self.dateFormatter.stringFromDate(date))")
        
    }
    
    func calendar(calendar: CKCalendarView!, didDeselectDate date: NSDate!) {
        var abc = CKDateItem()
        abc.backgroundColor = UIColor.clearColor()
        chosenDates.removeObject(date)
    }
    
    func calendar(calendar: CKCalendarView!, willChangeToMonth date: NSDate!) -> Bool {
        
        return true
    }
    
    func calendar(calendar: CKCalendarView!, didChangeToMonth date: NSDate!) {
        currentDate = date
        self.getBookingDetails(currentDate)
        //println("changed month \(self.dateFormatter.stringFromDate(date))")
        
    }
    
    
    func returnDate(date: NSDate) {
        //let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components(NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate: date)
        let firstDay = self.returnDateForMonth(dateComponents.month, year: dateComponents.year, day: 1)
        let lastDay = self.returnDateForMonth(dateComponents.month+1, year: dateComponents.year, day: 0)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        monthStartDate = "\(dateFormatter.stringFromDate(firstDay))"
        monthEndDate = "\(dateFormatter.stringFromDate(lastDay) )"
        println("First day of this month: \(dateFormatter.stringFromDate(firstDay) )")
        println("Last day of this month: \(dateFormatter.stringFromDate(lastDay) )")// 01-Sep-15
        
    }
    func returnDateForMonth(month:NSInteger, year:NSInteger, day:NSInteger)->NSDate{
        let comp = NSDateComponents()
        comp.month = month
        comp.year = year
        comp.day = day
        //print(comp)
        let grego = NSCalendar.currentCalendar()
        return grego.dateFromComponents(comp)!
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
