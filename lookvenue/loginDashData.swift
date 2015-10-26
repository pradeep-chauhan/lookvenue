//
//  loginDashData.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 10/24/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import Foundation
class loginDashData {
    static let sharedInstance = loginDashData()
    var loginDetails : NSMutableArray = NSMutableArray()
    
}
class loginClass {
    static let loginSharedInstance = loginClass()
    var login:loginDetails = loginDetails()
}