//
//  login.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class login:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var loginDetailsListArray : NSArray!
    var loginDetailsArray : NSMutableArray = NSMutableArray()
    
    var LoginDetails: loginDetails = loginDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
        self.password.delegate = self
        // Calling side mune bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        // center image in nav bar
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "look-venue-logo.png")
        imageView.image = image
        //self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationItem.titleView = imageView
        
        
//        let leftBarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        //set image for button
//        leftBarButton.setImage(UIImage(named: "menu-icon.png"), forState: UIControlState.Normal)
//        //add function for button
//        leftBarButton.addTarget(self, action: "leftSideMenuButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
//        //set frame
//        leftBarButton.frame = CGRectMake(0, 0,20, 20)
//        
//        let leftMenubarButton = UIBarButtonItem(customView: leftBarButton)
//        //assign button to navigationbar
//        self.navigationItem.leftBarButtonItem = leftMenubarButton
        
        
        
    }
    
    func getLoginDetailsArray() -> Void
    {
        loginDetailsArray = loginDetailsListArray as! NSMutableArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftSideMenuButtonPressed() {
        self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
            
        }
    }
    
    // MARK: - ENSideMenu Delegate
    

    @IBAction func showForgotPasswordAction(sender: AnyObject) {
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
    }
    
    @IBAction func loginButtonAction(sender: AnyObject) {
        var username = "pankaj@gkmit.co"//self.username.text
        var password = "1"//self.password.text
        var param1: String = username
        var param2: String = password
        var device_token = "123"
        var methodType: String = "GET"
        var base: String = "user_sign_in?email=\(param1)&password=\(param2)&device_token=\(device_token)"
        
        
        var urlRequest: String = base
        var serviceCall : WebServiceCall = WebServiceCall()
        //indicator.startAnimating()
        
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, completion: {(resultData : NSData) -> Void in
            println("hello user")
            self.loginDetailsListArray = serviceCall.getLoginDetailsArray(resultData)
            self.getLoginDetailsArray()
            println(self.loginDetailsListArray)
            if(self.loginDetailsListArray.count == 0) {
                let alert = UIAlertView()
                alert.title = "Sorry!"
                alert.message = "username and password is wrong"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
            else {
                 //Calling view Controller
                var storyBoard = UIStoryboard(name: "Main", bundle: nil)
                var dash : DashBoardViewController = storyBoard.instantiateViewControllerWithIdentifier("DashboardView") as! DashBoardViewController
                dash.LoginDetails = self.LoginDetails
                self.navigationController?.pushViewController(dash, animated: true)
            }
        })
        
        // Calling view Controller
//        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        var dash : DashBoardViewController = storyBoard.instantiateViewControllerWithIdentifier("DashboardView") as! DashBoardViewController
//        self.navigationController?.pushViewController(dash, animated: true)
        
        
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
