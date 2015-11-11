//
//  DashBoardViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/8/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
   
    let identifier = "Cell"
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var DashBoardTabBar: UITabBar!
    
    var propertyListArray : NSArray!
    var propertyArray : NSMutableArray = NSMutableArray()
    
    var LoginDetails: loginDetails = loginDetails()
    var LoginDetailsArray:NSMutableArray = NSMutableArray()
    
    var menuName = [ "Edit Proprty","Calendar","Settings" ]
    var menuImage = [ "home-small-red.png","calendar-red.png","settings-red.png" ]
    
    var selectedPropertyDetailsArray : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedPropertyDetailsArray = NSMutableArray()
        selectedPropertyDetailsArray = dashData.sharedInstance.selectedPropertyDetailsArray
        //var authentication = ( LoginDetails.remember_token as NSString) as String
        
        DashBoardTabBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        //self.DashBoardTabBar.tintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        //self.DashBoardTabBar.barTintColor
        // center image in nav bar
        
        //self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationItem.title = selectedPropertyDetailsArray[0]["name"] as! NSString as String
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
    
    func leftSideMenuButtonPressed() {
        self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! propertyTableViewCell
        
        var imageString = menuImage[indexPath.row]
        var image = UIImage(named: imageString)
        cell.label.text = menuName[indexPath.row] as String
        cell.imageName.image = image
        cell.accessoryType  = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuName.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if(indexPath.row == 0) {
            
            var dash : propertyInfoSegmentViewController = storyBoard.instantiateViewControllerWithIdentifier("propertyInfoSegment") as! propertyInfoSegmentViewController
            dash.LoginDetails = LoginDetails
            dash.selectedPropertyDetailsArray = selectedPropertyDetailsArray
            self.navigationController?.pushViewController(dash, animated: true)
        }
        else if(indexPath.row == 1) {
            
            var dash : calendarViewController = storyBoard.instantiateViewControllerWithIdentifier("calendarViewController") as! calendarViewController
            dash.selectedPropertyDetailsArray = selectedPropertyDetailsArray
            dash.LoginDetails = LoginDetails
            self.navigationController?.pushViewController(dash, animated: true)
        }
        else if(indexPath.row == 2) {
            
            var dash : SettingsViewController = storyBoard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
            dash.selectedPropertyDetailsArray = selectedPropertyDetailsArray
            self.navigationController?.pushViewController(dash, animated: true)
        }
        else {
            
        }
        
    }
    
    
    
//    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
//        if(item.tag == 0) {
//            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            var dash : ListPropertyViewController = storyBoard.instantiateViewControllerWithIdentifier("ListPropertyViewController") as! ListPropertyViewController
//            dash.LoginDetails = LoginDetails
//            dash.LoginDetailsArray = LoginDetailsArray
//            //dash.propertyArray = self.propertyArray
//            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
//            self.displayControllerView.addSubview(dash.view)
//            self.addChildViewController(dash)
//        }
//        else if(item.tag == 1) {
//            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            var dash : propertyInfoSegmentViewController = storyBoard.instantiateViewControllerWithIdentifier("propertyInfoSegment") as! propertyInfoSegmentViewController
//            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
//            self.displayControllerView.addSubview(dash.view)
//            self.addChildViewController(dash)
//        }
//        else if(item.tag == 2) {
//            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            var dash : calendarViewController = storyBoard.instantiateViewControllerWithIdentifier("calendarViewController") as! calendarViewController
//            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
//            self.displayControllerView.addSubview(dash.view)
//            self.addChildViewController(dash)
//        }
//        else if(item.tag == 3) {
//            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            var dash : contactUs = storyBoard.instantiateViewControllerWithIdentifier("contactUs") as! contactUs
//            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
//            self.displayControllerView.addSubview(dash.view)
//            self.addChildViewController(dash)
//        }
//        else if(item.tag == 4) {
//            var storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            var dash : SettingsViewController = storyBoard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
//            dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
//            self.displayControllerView.addSubview(dash.view)
//            self.addChildViewController(dash)
//        }
//        else {
//            println("tab bar")
//        }
//    }
    
    
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
