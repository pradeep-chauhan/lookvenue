//
//  ViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/4/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit
//import Alamofire

class ViewController : UIViewController, ENSideMenuDelegate{
    //@IBAction var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize font
        OpenSans.registerFonts()
        UILabel.appearance().font = UIFont(name: "OpenSans", size: 15)
        UITextField.appearance().font = UIFont(name: "OpenSans", size: 17)
        //UIButton.appearance()= UIFont(name: "OpenSans", size: 20)
        
        // Set Background color(android app bg color)
        var bgColorCode = UIColor(red: 210, green: 63, blue: 49, alpha: 1)
        
        // left bar button menu
        
        let leftBarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        //set image for button
        leftBarButton.setImage(UIImage(named: "menu-icon.png"), forState: UIControlState.Normal)
        //add function for button
        leftBarButton.addTarget(self, action: "ToggleButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        leftBarButton.frame = CGRectMake(0, 0,30, 30)
        
        let leftMenubarButton = UIBarButtonItem(customView: leftBarButton)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = leftMenubarButton
        
        // right bar button menu
        
        let rightBarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        //set image for button
        rightBarButton.setImage(UIImage(named: "search-icon.png"), forState: UIControlState.Normal)
        //add function for button
        rightBarButton.addTarget(self, action: "SearchButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        rightBarButton.frame = CGRectMake(0, 0,30, 30)
        
        let barButton = UIBarButtonItem(customView: rightBarButton)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SearchButtonPressed() {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var dash : searchProperrty = storyBoard.instantiateViewControllerWithIdentifier("searchPropertyInfo") as! searchProperrty
        self.navigationController?.pushViewController(dash, animated: true)
    }
    
    
    
//    @IBAction func login() {
//        //println("Login Button pressed")
//        let alert = UIAlertController(title: "Message",
//        message: "Hello Pradeep",
//        preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
//            action in self.login()
//        }))
//    }
}

