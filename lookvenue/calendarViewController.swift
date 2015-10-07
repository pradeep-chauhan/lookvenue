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
    var pmcc: PMCalendarView = PMCalendarView()
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        self.calendar = PMCalendarController(themeName: "apple calendar")
        self.view.addSubview(pmcc)
        showCalendar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendarController(calendarController: PMCalendarController!, didChangePeriod newPeriod: PMPeriod!) {
        println ("selected")
    }
    
    func showCalendar () {
        println("calendar")
        self.calendar.calendarVisible
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
