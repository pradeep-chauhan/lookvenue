//
//  ListPropertyViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/5/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class ListPropertyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var propertyListArray : NSArray!
    var propertyArray : NSMutableArray = NSMutableArray()
    
    var LoginDetails: loginDetails = loginDetails()
    var webhearder: WebServiceCall = WebServiceCall()
    
    var menuType = ["a","b","c","d"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webhearder.authentication = LoginDetails.remember_token as String
        webhearder.contentType = "application/json"
        
        println( webhearder.authentication)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        //self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        
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
        
        
        var methodType: String = "GET"
        var base: String = "property"
        var param: String = ""
        var urlRequest: String = base
        
        var serviceCall : WebServiceCall = WebServiceCall()
        //indicator.startAnimating()
        serviceCall.apiCallRequest(methodType, urlRequest: urlRequest) { (resultData) -> () in
            self.propertyListArray = serviceCall.getPropertyDetailsArray(resultData)
            self.getPropertyArray()
            
            
        }
        
        
    }
    
    func getPropertyArray() -> Void
    {
        propertyArray = propertyListArray as! NSMutableArray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! DashBoardTableViewCell
        
        cell.propertyName.text = menuType[indexPath.row] as String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuType.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if( indexPath.row == 0) {
            var dash : addProperty = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
            self.navigationController?.pushViewController(dash, animated: true)
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
