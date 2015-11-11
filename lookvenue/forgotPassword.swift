//
//  forgotPassword.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class forgotPassword:ViewController {

    @IBOutlet weak var forgotButton: UIButton!
    
    @IBOutlet weak var buttonSaprator: UILabel!
    @IBOutlet weak var signUpbutton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButton(sender: AnyObject) {
        var alert = UIAlertController(title: "Message", message: "Thank You! Pradeep- Its working now", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.forgotButton.layer.cornerRadius = 5
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.forgotButton.backgroundColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1)
        self.loginButton.tintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1)
        self.signUpbutton.tintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1)
        self.buttonSaprator.tintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1)
        //navigationController?.hidesBarsOnTap = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


