//
//  calendarViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class calendarViewController: UIViewController, PMCalendarControllerDelegate {
    
    var calendar: PMCalendarController = PMCalendarController()
    var selectedPropertyDetailsArray : NSMutableArray = NSMutableArray()
    var calendarDetailsListArray : NSArray!
    var calendarDetailsArray : NSMutableArray = NSMutableArray()
    var LoginDetails: loginDetails = loginDetails()
     //@property (nonatomic, assign) CGSize size;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //**********************************//
        self.calendar = PMCalendarController(themeName: "apple calendar")
        self.calendar.delegate = self
        self.calendar.presentCalendarFromRect(CGRectMake(0, 0, self.view.frame.width, 65), inView: self.view, permittedArrowDirections: PMCalendarArrowDirectionAny, animated: true)
        var size:CGSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.calendar.size = size
        //self.calendar.period = PMPeriod.oneDayPeriodWithDate(NSDate.date())
        
        
        var authentication = ( self.LoginDetails.remember_token as NSString) as String
        var methodType: String = "GET"
        var base: String = "bookings?"
        
        var monthStartDate = calendar.period.startDate.monthStartDate().dateStringWithFormat("yyyy-MM-dd")
        var noOfdaysInMonth = Int(calendar.period.startDate.numberOfDaysInMonth())
        var monthEndDate = calendar.period.startDate.monthStartDate().dateByAddingDays(noOfdaysInMonth - 1).dateStringWithFormat("yyyy-MM-dd")
        
        
        var startDate = "\(monthStartDate)"
        var endDate = "\(monthEndDate)"
        var propertyId = (selectedPropertyDetailsArray[0]["id"] as! NSNumber).stringValue
        var param: String = "property_id=\(propertyId)&start_date=\(startDate)&end_date=\(endDate)"
        var urlRequest: String = base + param
        var serviceCall : WebServiceCall = WebServiceCall()
        serviceCall.adminApiCallRequest(methodType, urlRequest: urlRequest, param:[:], authentication: authentication, completion: { (resultData) -> () in
            self.calendarDetailsListArray = serviceCall.getCalendarDetailsArray(resultData)
            self.getCalendarDetailsArray()
            println("calendar details====\(self.calendarDetailsArray)")
            self.calendarController(self.calendar, didChangePeriod: self.calendar.period)
        })
        // Do any additional setup after loading the view.
    }
    
    func getCalendarDetailsArray () -> Void {
        
        calendarDetailsArray = calendarDetailsListArray as! NSMutableArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendarController(calendarController: PMCalendarController!, didChangePeriod newPeriod: PMPeriod!) {
        var date = newPeriod.startDate.dateStringWithFormat("yyyy-MM-dd")
        println ("selected date: \(date)")
        println("current date : \(newPeriod)")
        
        
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
