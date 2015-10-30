//
//  signUp.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class signUp: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var signUPListArray:NSArray!
    var signUPArray:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.password.delegate = self
        self.email.delegate = self
        self.name.delegate = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        // center image in nav bar
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "look-venue-logo.png")
        imageView.image = image
        //self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationItem.titleView = imageView
        
        
        let leftBarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        //set image for button
        leftBarButton.setImage(UIImage(named: "menu-icon.png"), forState: UIControlState.Normal)
        //add function for button
        leftBarButton.addTarget(self, action: "leftSideMenuButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        //set frame
        leftBarButton.frame = CGRectMake(0, 0,20, 20)
        
        let leftMenubarButton = UIBarButtonItem(customView: leftBarButton)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = leftMenubarButton
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func leftSideMenuButtonPressed() {
        self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
            
        }
    }
    
    @IBAction func showForgotPasswordAction(sender: AnyObject) {
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        //textField.resignFirstResponder()
        return false
    }
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
        //return true
    }
    
    func getSignUpArray() -> Void
    {
        signUPArray = signUPListArray as! NSMutableArray
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
//        DPNotify.sharedNotify.showNotifyInView(view, title:"working", dismissOnTap: true, notifyType: .DEFAULT)
//        println(DPNotify)
        
        var email = self.email.text
        var password = self.password.text
        var name = self.name.text
        
        let loadingProgress = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingProgress.detailsLabelText = "Please wait"
        
        var methodType: String = "POST"
        var base: String = "users"
        var param: String = ""
        var urlRequest: String = base
        var details = [
            "name":name,
            "email":email,
            "password":password
        ]
        var user = [
            "user":details
        ]
        
        var serviceCall : WebServiceCall = WebServiceCall()
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest, param: user ,completion: { (resultData) -> () in
        
            self.signUPListArray = serviceCall.signUpResult(resultData)
            println(self.signUPListArray )
            if (( self.signUPArray.valueForKey("error")) != nil) {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                let message = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                message.mode = MBProgressHUDMode.Text
                message.detailsLabelText = self.signUPArray.valueForKey("error") as! NSString as String
                message.hide(true, afterDelay: 3)
            }
            else {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                let message = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                message.mode = MBProgressHUDMode.Text
                message.detailsLabelText = "Done"
                message.hide(true, afterDelay: 3)
            }
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
        })
        
//        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        var dash : DashBoardViewController = storyBoard.instantiateViewControllerWithIdentifier("DashboardView") as! DashBoardViewController
//        self.navigationController?.pushViewController(dash, animated: true)
        
        
    }

}
