//
//  addProperty.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class addProperty: ViewController, UITextFieldDelegate, SACalendarDelegate{

    var calendar : SACalendar = SACalendar()
    @IBOutlet var addPropertyScrollView: UIScrollView!
   
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding scroll bar
        self.addPropertyScrollView.contentSize=CGSize(width:0, height: 800);
        self.addPropertyScrollView.showsVerticalScrollIndicator = true
        view.addSubview(addPropertyScrollView)
        
        self.emailTextField.delegate = self
        // Do any additional setup after loading the view.
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
        
        // Calling Calendar Event
        calendar = SACalendar(frame:CGRectMake(0, 0, 320, 400),scrollDirection:ScrollDirectionVertical,pagingEnabled:false)
        calendar.delegate=self
        self.view.addSubview(calendar)
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
