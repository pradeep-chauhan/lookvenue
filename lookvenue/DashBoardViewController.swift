//
//  DashBoardViewController.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/8/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class DashBoardViewController: ViewController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.sideMenuController()?.sideMenu?.delegate = self
        
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRectMake(160, 27, 30, 30));
        imageView.image = UIImage(named:"look-venue-logo.png")
        self.navigationController!.view.addSubview(imageView)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func ToggleButtonAction(sender:UIButton)
    {
        toggleSideMenuView()
    }
    
    @IBAction func editPropertyButton(sender: AnyObject) {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var dash : addProperty = storyBoard.instantiateViewControllerWithIdentifier("editPropertyView") as! addProperty
        self.navigationController?.pushViewController(dash, animated: true)
    }
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        println("sideMenuShouldOpenSideMenu")
        return true
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
