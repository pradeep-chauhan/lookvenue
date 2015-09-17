//
//  login.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class login:ViewController, ENSideMenuDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calling side mune bar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.sideMenuController()?.sideMenu?.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ToggleButtonAction(sender:UIButton)
    {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return true
    }

    @IBAction func showForgotPasswordAction(sender: AnyObject) {
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
    }
    
    @IBAction func loginButtonAction(sender: AnyObject) {
        
        // Calling view Controller
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var dash : DashBoardViewController = storyBoard.instantiateViewControllerWithIdentifier("DashboardView") as! DashBoardViewController
        self.navigationController?.pushViewController(dash, animated: true)
        
        
//        var request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "http:lookvenue.herokuapp.com/property_types/")!)
//        request.HTTPMethod = "GET"
//        var error : NSError?
//        var response : NSURLResponse?
//        
//        var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)!
//        
//        if(error == nil)
//        {
//            var resultString : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
//            var dictionary : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSArray
//            println((dictionary[0] as! NSDictionary).valueForKey("name"))
//            println(resultString)
//        }
//        else
//        {
//            println(error?.localizedDescription)
//        }
        
        
//                var request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "http://lookvenue.herokuapp.com/user_sign_in?email=prdpchauhan4@gmail.com&password=1&device_token=123")!)
//                request.HTTPMethod = "GET"
//                var error : NSError?
//                var response : NSURLResponse?
//        
//                var data : NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)!
//        
//                if(error == nil)
//                {
//                    var resultString : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
//                    var dictionary : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSArray
//                    println((dictionary[0] as! NSDictionary).valueForKey("email"))
//                    println(resultString)
//                    
//                }
//                else
//                {
//                    println(error?.localizedDescription)
//                }

        
    }

}