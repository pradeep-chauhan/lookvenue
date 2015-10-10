//
//  LeftSideMenuViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/29/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class LeftSideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    let identifier = "cell"
    var menuLabel = ["Home","List Property","Manage Property"]
    var menuImage = ["home.png","list.png","manage.png"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: UIView!
    
    @IBOutlet weak var leftMenuTabBar: UITabBar!
    
    var share:String! = "share"
    var feedback:String! = nil
    var rate:String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftMenuTabBar.delegate = self
        //self.leftMenuTabBar.barTintColor = UIColor(red: 210.0/255.0, green: 67.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        self.leftMenuTabBar.tintColor = UIColor(red: 210.0/255.0, green: 67.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        //UITabBar.appearance().s = UIColor.whiteColor()
        
        //self.navigationController?.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
       
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(red: 52.0/255.0, green: 52.0/255.0, blue: 52.0/255.0, alpha: 0.8)
        
        bannerView.backgroundColor = UIColor(red: 210.0/255.0, green: 67.0/255.0, blue: 49.0/255.0, alpha: 0.9)
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return menuLabel.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! LeftMenuTableViewCell
        
        var imageString = menuImage[indexPath.row]
        var image = UIImage(named: imageString)
        
        cell.MenuType.text = menuLabel[indexPath.row] as String
        cell.MenuImage.image =  image
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if(indexPath.row == 0) {
            let dash : searchProperrty = storyboard.instantiateViewControllerWithIdentifier("searchPropertyInfo") as! searchProperrty
            
            self.navigationController!.pushViewController(dash, animated: true)
            
            //self.presentViewController(dash, animated: true, completion: nil)
            
        }
        else if(indexPath.row == 1) {
            var dash : UINavigationController = storyboard.instantiateViewControllerWithIdentifier("loginNav") as! UINavigationController
            //var  dash : login = storyboard.instantiateViewControllerWithIdentifier("LoginView") as! login
            self.menuContainerViewController.centerViewController = dash
        }
        else if (indexPath.row == 2) {
            var dash : signUp = storyboard.instantiateViewControllerWithIdentifier("SignupView") as! signUp
            //self.navigationController?.pushViewController(dash, animated: true)
            self.presentViewController(dash, animated: true, completion: nil)
        }
        else {
            println(indexPath.row)
        }
        self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
            
        }
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if(item.tag == 0) {
            if( share != nil) {
                let textToShare = "Lookvenue is awesome!  Check out this website about it!"
                
                if let myWebsite = NSURL(string: "http://www.lookvenue.com/")
                {
                    let objectsToShare = [textToShare, myWebsite]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                    self.presentViewController(activityVC, animated: true, completion: nil)
                }
            }
            else {
                let alert = UIAlertView()
                alert.title = "Sorry!"
                alert.message = "Share is not available for this business"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        else if(item.tag == 1) {
            if( rate != nil) {
                UIApplication.sharedApplication().openURL(NSURL(string: "mailto://" + rate)!)
            }
            else {
                let alert = UIAlertView()
                alert.title = "Sorry!"
                alert.message = "Rate is not available for this business"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        else if(item.tag == 2) {
            if( feedback != nil) {
                UIApplication.sharedApplication().openURL(NSURL(string: "mailto://" + feedback)!)
            }
            else {
                let alert = UIAlertView()
                alert.title = "Sorry!"
                alert.message = "Feedback is not available for this business"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
        else {
            println("tab bar")
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
