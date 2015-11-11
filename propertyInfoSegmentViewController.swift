
//
//  propertyInfoSegmentViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/11/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class propertyInfoSegmentViewController: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var addpropertyViewController : addProperty = addProperty()
    var propertyArray:NSMutableArray = NSMutableArray()
    var imageProperty : imagePropertyViewController = imagePropertyViewController()
    var selectedPropertyDetailsArray : NSMutableArray = NSMutableArray()
    var LoginDetails: loginDetails = loginDetails()
    var editPropertyListArray : NSArray!
    var editPropertyArray : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Loading window show
        self.segmentControl.tintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1)
        let loadingProgress = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingProgress.labelText = "Loading"
        
        if( self.selectedPropertyDetailsArray.count > 0 ) {
            
            
            var authentication = ( self.LoginDetails.remember_token as NSString) as String
            var methodType: String = "GET"
            var propertyId = (selectedPropertyDetailsArray[0]["id"] as! NSNumber).stringValue
            //println(propertyId)
            var base: String = "properties/\(propertyId).json"
            var param: String = ""
            var urlRequest: String = base
            var serviceCall : WebServiceCall = WebServiceCall()
            
            serviceCall.adminApiCallRequest(methodType, urlRequest: urlRequest, param: [:], authentication: authentication) { (resultData : NSData) -> Void in
                self.editPropertyListArray = serviceCall.getEditPropertyArray(resultData)
                self.getEditPropertyArray()
                //self.indicator.stopAnimating()
                //println(self.editPropertyArray)
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                //alert.dismissWithClickedButtonIndex(0, animated: true)
                
                if(self.segmentControl.selectedSegmentIndex == 0)
                {
                    
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    self.addpropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
                    self.addpropertyViewController.editPropertyArray = self.editPropertyArray
                    self.addpropertyViewController.selectedPropertyDetailsArray = self.selectedPropertyDetailsArray
                    self.addpropertyViewController.LoginDetails = self.LoginDetails
                    self.addpropertyViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)
                    self.containerView.addSubview(self.addpropertyViewController.view)
                    self.addChildViewController(self.addpropertyViewController)
                    self.addpropertyViewController.didMoveToParentViewController(self)
                    
                }
                else if(self.segmentControl.selectedSegmentIndex == 1)
                {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    self.imageProperty = storyBoard.instantiateViewControllerWithIdentifier("propertyImages") as! imagePropertyViewController
                    self.imageProperty.editPropertyArray = self.editPropertyArray
                    self.imageProperty.LoginDetails = self.LoginDetails
                    self.imageProperty.view.frame = self.containerView.bounds
                    self.containerView.addSubview(self.imageProperty.view)
                    self.addChildViewController(self.imageProperty)
                    self.imageProperty.didMoveToParentViewController(self)
                }
                
            }
        }
        else {
            
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
            self.navigationItem.title = "Add Property"
            let leftBarButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            // image for button
            leftBarButton.setImage(UIImage(named: "arrow-left.png"), forState: UIControlState.Normal)
            //set frame
            leftBarButton.frame = CGRectMake(0, 0,20, 20)
            leftBarButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            
            let leftMenubarButton = UIBarButtonItem(customView: leftBarButton)
            //assign button to navigationbar
            self.navigationItem.leftBarButtonItem = leftMenubarButton
            
            self.selectedPropertyDetailsArray = []
            self.editPropertyArray = []
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            if(self.segmentControl.selectedSegmentIndex == 0)
            {
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                self.addpropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
                self.addpropertyViewController.editPropertyArray = self.editPropertyArray
                self.addpropertyViewController.selectedPropertyDetailsArray = self.selectedPropertyDetailsArray
                //self.addpropertyViewController.LoginDetails = self.LoginDetails
                self.addpropertyViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)
                self.containerView.addSubview(self.addpropertyViewController.view)
                self.addChildViewController(self.addpropertyViewController)
                self.addpropertyViewController.didMoveToParentViewController(self)
                
            }
            else if(self.segmentControl.selectedSegmentIndex == 1)
            {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                self.imageProperty = storyBoard.instantiateViewControllerWithIdentifier("propertyImages") as! imagePropertyViewController
                self.imageProperty.editPropertyArray = self.editPropertyArray
                //self.imageProperty.LoginDetails = self.LoginDetails
                self.imageProperty.view.frame = self.containerView.bounds
                self.containerView.addSubview(self.imageProperty.view)
                self.addChildViewController(self.imageProperty)
                self.imageProperty.didMoveToParentViewController(self)
            }

        }
        
        

    }
    
    func backButtonPressed() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getEditPropertyArray() -> Void
    {
        editPropertyArray = editPropertyListArray as! NSMutableArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlAction(sender: AnyObject) {
        if(segmentControl.selectedSegmentIndex == 0)
        {
            //self.navigationItem.rightBarButtonItem = nil
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            addpropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
            addpropertyViewController.propertyArray = propertyArray
            addpropertyViewController.selectedPropertyDetailsArray = self.selectedPropertyDetailsArray
            addpropertyViewController.editPropertyArray = self.editPropertyArray
            addpropertyViewController.LoginDetails = self.LoginDetails
            addpropertyViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)
            self.containerView.addSubview(addpropertyViewController.view)
            self.addChildViewController(addpropertyViewController)
            addpropertyViewController.didMoveToParentViewController(self)

        }
        else if(segmentControl.selectedSegmentIndex == 1)
        {
            //self.navigationItem.rightBarButtonItem = editButtonItem()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            imageProperty = storyBoard.instantiateViewControllerWithIdentifier("propertyImages") as! imagePropertyViewController
             self.imageProperty.editPropertyArray = self.editPropertyArray
            imageProperty.LoginDetails = self.LoginDetails
            imageProperty.view.frame = self.containerView.bounds
            self.containerView.addSubview(imageProperty.view)
            self.addChildViewController(imageProperty)
            imageProperty.didMoveToParentViewController(self)
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

}
