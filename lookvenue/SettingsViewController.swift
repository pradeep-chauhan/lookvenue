//
//  SettingsViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailNotification: UISwitch!
    @IBOutlet weak var pushNotification: UISwitch!
    var selectedPropertyDetailsArray : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoutButton.layer.cornerRadius = 5
        self.logoutButton.backgroundColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1)
        pushNotification.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        emailNotification.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func emailSwitch(sender: AnyObject) {
//        if(emailNotification.on) {
//            emailNotification.setOn(false, animated: true)
//        }
//        else {
//            emailNotification.setOn(true, animated: true)
//        }
    }
   
    @IBAction func pushSwitch(sender: AnyObject) {
//        if(pushNotification.on) {
//            pushNotification.setOn(false, animated: true)
//        }
//        else {
//            pushNotification.setOn(true, animated: true)
//        }
    }
    
    func stateChanged(switchState: UISwitch) {
        if(switchState.tag == 1) {
            if switchState.on {
                println("The Switch is On")
            } else {
                println("The Switch is Off")
            }
        }
        else {
            if switchState.on {
                println("The Switch is On")
            } else {
                println("The Switch is Off")
            }
        }
        
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("logout", object: nil)
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
