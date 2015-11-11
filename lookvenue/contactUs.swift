//
//  contactUs.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/6/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit

class contactUs: ViewController {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        self.messageView.layer.borderWidth = 0.5
        self.messageView.layer.cornerRadius = 5
        self.messageView.clipsToBounds = true
        self.sendButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
