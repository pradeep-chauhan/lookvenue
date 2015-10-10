//
//  ListPropertyViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/5/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class ListPropertyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
   
    @IBOutlet weak var addPropertyButton: UIButton!
    @IBOutlet weak var topBanner: UIView!
    var propertyArray : NSMutableArray = NSMutableArray()
    var propertyListArray : NSArray!
    var LoginDetails: loginDetails = loginDetails()
    var webhearder: WebServiceCall = WebServiceCall()
    
   var LoginDetailsArray:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBanner.backgroundColor = UIColor(red: 210.0/255.0, green: 63.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(red: 52.0/255.0, green: 52.0/255.0, blue: 52.0/255.0, alpha: 0.8)
        //self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! DashBoardTableViewCell
        
        cell.propertyName.text = propertyArray[indexPath.row]["name"] as! NSString as String
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        var dash : propertyInfoSegmentViewController = storyBoard.instantiateViewControllerWithIdentifier("propertyInfoSegment") as! propertyInfoSegmentViewController
       
        var selectedPropertyDetailsArray : NSMutableArray = NSMutableArray()
        var tempDict : NSDictionary = propertyArray[indexPath.row] as! NSDictionary
        selectedPropertyDetailsArray.addObject(tempDict)
        println(selectedPropertyDetailsArray)
        dash.propertyArray = selectedPropertyDetailsArray
        self.navigationController?.pushViewController(dash, animated: true)
//        dash.view.frame = CGRectMake(0, 0, self.displayControllerView.frame.size.width, self.displayControllerView.frame.size.height)
//        
//        self.displayControllerView.addSubview(dash.view)
        self.addChildViewController(dash)
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
