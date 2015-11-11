//
//  addNewPropertyViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/28/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class addNewPropertyViewController: UIViewController {

    @IBOutlet weak var addPropertyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addPropertyButton.layer.cornerRadius = 5
        self.addPropertyButton.backgroundColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)

        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        //self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
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
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func leftSideMenuButtonPressed() {
        self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addProperty(sender: AnyObject) {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var dash : propertyInfoSegmentViewController = storyBoard.instantiateViewControllerWithIdentifier("propertyInfoSegment") as! propertyInfoSegmentViewController
        //dash.editPropertyArray = []
        self.navigationController?.pushViewController(dash, animated: true)
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
