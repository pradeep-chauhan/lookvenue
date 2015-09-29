//
//  LeftSideMenuViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 9/29/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class LeftSideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let identifier = "cell"
    var menuLabel = ["Home","List Property","Manage Property"]
    var menuImage = ["","",""]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
//        // center image in nav bar
//        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
//        imageView.contentMode = .ScaleAspectFit
//        
//        let image = UIImage(named: "look-venue-logo.png")
//        imageView.image = image
//        //self.navigationController?.setToolbarHidden(true, animated: false)
//        self.navigationItem.titleView = imageView
//        
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
        
        
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 52.0/255.0, green: 52.0/255.0, blue: 52.0/255.0, alpha: 0.8)
        
        
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
        var image = UIImage(contentsOfFile: menuImage[indexPath.row])
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
            self.navigationController?.pushViewController(dash, animated: true)
            //self.presentViewController(dash, animated: true, completion: nil)
            
        }
        else if(indexPath.row == 1) {
            var dash : login = storyboard.instantiateViewControllerWithIdentifier("LoginView") as! login
            self.navigationController?.pushViewController(dash, animated: true)
        }
        else if (indexPath.row == 2) {
            var dash : signUp = storyboard.instantiateViewControllerWithIdentifier("SignupView") as! signUp
            self.navigationController?.pushViewController(dash, animated: true)
        }
        else {
            println(indexPath.row)
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
