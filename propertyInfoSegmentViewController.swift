
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
        
        
        var authentication = ( self.LoginDetails.remember_token as NSString) as String
        var methodType: String = "GET"
        var propertyId = (selectedPropertyDetailsArray[0]["id"] as! NSNumber).stringValue
        //println(propertyId)
        var base: String = "properties/\(propertyId).json"
        var param: String = ""
        var urlRequest: String = base
        var serviceCall : WebServiceCall = WebServiceCall()
        
        // Loading window show
        
        var alert = UIAlertView(title: "Loading...", message: nil, delegate: self, cancelButtonTitle: nil)
        var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 20, 37, 37)) as UIActivityIndicatorView
        loadingIndicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50)
       
        loadingIndicator.hidesWhenStopped = true
        
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        alert.show();
        
        
        serviceCall.adminApiCallRequest(methodType, urlRequest: urlRequest, authentication: authentication) { (resultData : NSData) -> Void in
            self.editPropertyListArray = serviceCall.getEditPropertyArray(resultData)
            self.getEditPropertyArray()
            //self.indicator.stopAnimating()
            //println(self.editPropertyArray)
            alert.dismissWithClickedButtonIndex(0, animated: true)
            if(self.segmentControl.selectedSegmentIndex == 0)
            {
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                self.addpropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
                self.addpropertyViewController.editPropertyArray = self.editPropertyArray
                self.addpropertyViewController.selectedPropertyDetailsArray = self.selectedPropertyDetailsArray
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
                self.imageProperty.view.frame = self.containerView.bounds
                self.containerView.addSubview(self.imageProperty.view)
                self.addChildViewController(self.imageProperty)
                self.imageProperty.didMoveToParentViewController(self)
            }
            
        }
        

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
