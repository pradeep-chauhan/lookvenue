//
//  calendarViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class calendarViewController: UIViewController, CKCalendarDelegate {
    
    var minimumDate:NSDate = NSDate()
    var chosenDates:NSMutableArray = NSMutableArray()
    
    var selectedPropertyDetailsArray : NSMutableArray = NSMutableArray()
    var calendarDetailsListArray : NSArray!
    var calendarDetailsArray : NSMutableArray = NSMutableArray()
    var LoginDetails: loginDetails = loginDetails()
     //@property (nonatomic, assign) CGSize size;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //**********************************//
        var calendar: CKCalendarView = CKCalendarView()
        
        calendar.delegate = self
        calendar.onlyShowCurrentMonth = false;
        calendar.adaptHeightToNumberOfWeeksInMonth = true;
        
        var selectedDate = CKDateItem()
        selectedDate.backgroundColor = UIColor.orangeColor()
        
        calendar.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height);
        self.view.addSubview(calendar)
        //self.calendar.period = PMPeriod.oneDayPeriodWithDate(NSDate.date())
        
        
        var authentication = ( self.LoginDetails.remember_token as NSString) as String
        var methodType: String = "GET"
        var base: String = "bookings?"
        
//        var monthStartDate = calendar.period.startDate.monthStartDate().dateStringWithFormat("yyyy-MM-dd")
//        var noOfdaysInMonth = Int(calendar.period.startDate.numberOfDaysInMonth())
//        var monthEndDate = calendar.period.startDate.monthStartDate().dateByAddingDays(noOfdaysInMonth - 1).dateStringWithFormat("yyyy-MM-dd")
//        
//        
//        var startDate = "\(monthStartDate)"
//        var endDate = "\(monthEndDate)"
//        var propertyId = (selectedPropertyDetailsArray[0]["id"] as! NSNumber).stringValue
//        var param: String = "property_id=\(propertyId)&start_date=\(startDate)&end_date=\(endDate)"
//        var urlRequest: String = base + param
//        var serviceCall : WebServiceCall = WebServiceCall()
//        serviceCall.adminApiCallRequest(methodType, urlRequest: urlRequest, param:[:], authentication: authentication, completion: { (resultData) -> () in
//            self.calendarDetailsListArray = serviceCall.getCalendarDetailsArray(resultData)
//            self.getCalendarDetailsArray()
//            println("calendar details====\(self.calendarDetailsArray)")
//        })
        // Do any additional setup after loading the view.
    }
    
    func getCalendarDetailsArray () -> Void {
        
        calendarDetailsArray = calendarDetailsListArray as! NSMutableArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendar(calendar: CKCalendarView!, configureDateItem dateItem: CKDateItem!, forDate date: NSDate!) {
        
        if chosenDates.containsObject(date) {
            dateItem.backgroundColor = UIColor.greenColor()
            println(chosenDates)
        }
        
        
    }
    
    func calendar(calendar: CKCalendarView!, willSelectDate date: NSDate!) -> Bool {
        var dateItem = CKDateItem()
        if date.laterDate(minimumDate) == minimumDate {
            dateItem.textColor = UIColor.grayColor()
        }
        return calendar.dateIsInCurrentMonth(date)
    }
    
    func calendar(calendar: CKCalendarView!, didSelectDate date: NSDate!) {
        var selectedDate = CKDateItem()
        selectedDate.backgroundColor = UIColor.redColor()
        chosenDates.addObject(date)
        println(date)
        
    }
    
    func calendar(calendar: CKCalendarView!, didDeselectDate date: NSDate!) {
        var abc = CKDateItem()
        abc.backgroundColor = UIColor.clearColor()
        chosenDates.removeObject(date)
        println("date = \(date)")
    }
    
    func calendar(calendar: CKCalendarView!, willChangeToMonth date: NSDate!) -> Bool {
        return true
    }
    func calendar(calendar: CKCalendarView!, didChangeToMonth date: NSDate!) {
        println("changed month")
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
