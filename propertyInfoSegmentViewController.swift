
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
    var imageProperty : imagePropertyViewController = imagePropertyViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.containerView.backgroundColor = UIColor.greenColor()
        
        
        if(segmentControl.selectedSegmentIndex == 0)
        {
            //self.imageProperty.removeFromParentViewController()
            //self.addpropertyViewController.view.removeFromSuperview()
            
            println("first index")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            addpropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
            addpropertyViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)
            self.containerView.addSubview(addpropertyViewController.view)
            self.addChildViewController(addpropertyViewController)
            addpropertyViewController.didMoveToParentViewController(self)
            
        }
        else if(segmentControl.selectedSegmentIndex == 1)
        {
            //self.imageProperty.removeFromParentViewController()
            //self.addpropertyViewController.view.removeFromSuperview()
            
            println("second index")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            imageProperty = storyBoard.instantiateViewControllerWithIdentifier("propertyImages") as! imagePropertyViewController
            imageProperty.view.frame = self.containerView.bounds
            self.containerView.addSubview(imageProperty.view)
            self.addChildViewController(imageProperty)
            imageProperty.didMoveToParentViewController(self)
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlAction(sender: AnyObject) {
        if(segmentControl.selectedSegmentIndex == 0)
        {
            //self.imageProperty.removeFromParentViewController()
            //self.addpropertyViewController.view.removeFromSuperview()
            
            println("first index")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            addpropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
            addpropertyViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)
            self.containerView.addSubview(addpropertyViewController.view)
            self.addChildViewController(addpropertyViewController)
            addpropertyViewController.didMoveToParentViewController(self)

        }
        else if(segmentControl.selectedSegmentIndex == 1)
        {
            //self.imageProperty.removeFromParentViewController()
           //self.addpropertyViewController.view.removeFromSuperview()
            
            println("second index")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            imageProperty = storyBoard.instantiateViewControllerWithIdentifier("propertyImages") as! imagePropertyViewController
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
