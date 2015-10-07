//
//  DashBoardViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/8/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var displayControllerView: UIView!
   
    @IBOutlet weak var DashBoardTabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    
    var LoginDetails: loginDetails = loginDetails()
    
//    var menuImage = ["home.png","calendar-clock.png","settings.png","phone.png"]
//    var menuType = ["Edit Property","Calender","Setting","contact"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DashBoardTabBar.delegate = self
        
        
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
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var dash : ListPropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("ListPropertyViewController") as! ListPropertyViewController
        dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
        dash.LoginDetails = LoginDetails
        self.displayControllerView.addSubview(dash.view)
        self.addChildViewController(dash)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if(item.tag == 0) {
            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var dash : ListPropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("ListPropertyViewController") as! ListPropertyViewController
            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
            self.displayControllerView.addSubview(dash.view)
            self.addChildViewController(dash)
        }
        else if(item.tag == 1) {
            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var dash : propertyInfoSegmentViewController = storyBoard.instantiateViewControllerWithIdentifier("propertyInfoSegment") as! propertyInfoSegmentViewController
            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
            self.displayControllerView.addSubview(dash.view)
            self.addChildViewController(dash)
        }
        else if(item.tag == 2) {
            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var dash : calendarViewController = storyBoard.instantiateViewControllerWithIdentifier("calendarViewController") as! calendarViewController
            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
            self.displayControllerView.addSubview(dash.view)
            self.addChildViewController(dash)
        }
        else if(item.tag == 3) {
            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var dash : contactUs = storyBoard.instantiateViewControllerWithIdentifier("contactUs") as! contactUs
            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
            self.displayControllerView.addSubview(dash.view)
            self.addChildViewController(dash)
        }
        else if(item.tag == 4) {
            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var dash : SettingsViewController = storyBoard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
            self.displayControllerView.addSubview(dash.view)
            self.addChildViewController(dash)
        }
        else {
            println("tab bar")
        }
    }
    
    
//    @IBAction func editPropertyButton(sender: AnyObject) {
//        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        var dash : addProperty = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
//        self.navigationController?.pushViewController(dash, animated: true)
//    }
    // MARK: - ENSideMenu Delegate
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
