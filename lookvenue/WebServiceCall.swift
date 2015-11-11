    //
//  WebServiceCall.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/27/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import UIKit
import Alamofire

class WebServiceCall: NSObject {
    
    var login:loginDetails = loginDetails()
    //let loadingProcess:MBProgressHUD = MBProgressHUD()
    var authentication = ""
    var cookies = ""
    var contentType = ""
    var window = UIApplication.sharedApplication().delegate!.window
    // user api call
    
    // Simple web calling function
    
    func apiCallRequest(methodType: String, urlRequest: String, param:Dictionary < String, AnyObject >, completion: (resultData : NSData) -> ()) -> Void
    {
        var baseUrl: String! = "http://lookvenue.herokuapp.com/"
        var method: String! = methodType
        var parameter: String! = urlRequest
        var url: String = baseUrl + parameter
       
        if( method == "GET") {
                Alamofire.request(.GET, url)
                    .validate()
                    .response { request, response, data, error in
                        
                        if(error != nil) {
                           
//                            println(error?.localizedDescription)
//                            var alert = UIAlertView(title: "No Internet!", message: error!.localizedDescription, delegate: self, cancelButtonTitle: "Ok")
//                            alert.show()
                            let loadingProcess = MBProgressHUD.showHUDAddedTo(self.window!, animated: true)
                            loadingProcess.mode = MBProgressHUDMode.Text
                            loadingProcess.detailsLabelText = error!.localizedDescription
                            loadingProcess.hide(true, afterDelay: 5)
                            //exit(0)
                            
                        }
                        else {
                            completion(resultData: data!)
                        }
                        
                        
                    }
           
        }
        
        else if (method == "upload") {
            let fileURL = NSBundle.mainBundle().URLForResource("Default", withExtension: "png")
            Alamofire.upload(.POST, url, file: fileURL!)
                .responseJSON { request, response, data, error in
                    if(error != nil) {
                        println(error?.localizedDescription)
                        var alert = UIAlertView(title: "No Internet!", message: error!.localizedDescription, delegate: self, cancelButtonTitle: "Ok")
                        alert.show()

                    }
                    else {
                        completion(resultData: data as! NSData)
                    }
            }
        }
            
        else {
//            var jsonData = NSJSONSerialization.dataWithJSONObject(param, options: nil, error: nil)
//            let jsonString = NSString(data: jsonData!, encoding: NSUTF8StringEncoding)! as String
//            println(jsonString)
            
            
            Alamofire.request(.POST, url, parameters: param, encoding: .JSON)
                .responseJSON { request, response, data, error in
                    println(data)
                    if(error != nil) {
                        println(response?.statusCode)
                        let loadingProcess = MBProgressHUD.showHUDAddedTo(self.window!, animated: true)
                        loadingProcess.mode = MBProgressHUDMode.Text
                        
                        loadingProcess.detailsLabelText = error!.localizedDescription
                        loadingProcess.hide(true, afterDelay: 5)
                    }
                    else {
                        let resultString : NSData = NSKeyedArchiver.archivedDataWithRootObject(data!)
                        completion(resultData: resultString)
                    }
                    //MBProgressHUD.hideAllHUDsForView(self.window!, animated: true)
            }
        }
    }
    
    // admin function call
    
    func adminApiCallRequest(methodType: String, urlRequest: String, param: Dictionary < String, AnyObject > , authentication: String , completion: (resultData : NSData) -> ()) -> Void
    {
        var baseUrl: String! = "http://lookvenue.herokuapp.com/"
        var method: String! = methodType
        //var parameter: NSArray = param
        var url: String = baseUrl + urlRequest
        
        var authentication:String = authentication
        let headers = [
            "Authorization": "\(authentication)",
            "Cookie": "remember_token=\(authentication)",
            "Content-Type": "application/json"
        ]
        if( method == "GET") {
            
                Alamofire.request(.GET, url, headers: headers)
                    
                    .response { request, response, data, error in
//                        println(data)
                        if(error != nil) {
                            println(response?.statusCode)
                            let loadingProcess = MBProgressHUD.showHUDAddedTo(self.window!, animated: true)
                            loadingProcess.mode = MBProgressHUDMode.Text
                            
                            loadingProcess.detailsLabelText = error!.localizedDescription
                            loadingProcess.hide(true, afterDelay: 5)
                            
                            
                        }
                        else {
                            completion(resultData: data!)
                        }
                        
                        
                    }
            
            }
        else if (method == "PUT") {
            println("param = \(param)")
            println("url = \(url)")
            println("demo")
            
            var jsonData = NSJSONSerialization.dataWithJSONObject(param, options: nil, error: nil)
            let jsonString = NSString(data: jsonData!, encoding: NSUTF8StringEncoding)! as String
            println(jsonString)
            
            let loadingProcess = MBProgressHUD.showHUDAddedTo(self.window!, animated: true)
            
            Alamofire.request(.PUT, url, parameters: param, encoding: .JSON, headers: headers)
                .responseJSON { request, response, data, error in
                    //println(response)
//                        let resultString : NSData = NSKeyedArchiver.archivedDataWithRootObject(data!)
//                        completion(resultData: resultString)
                        if( response?.statusCode == 200 ) {
                            loadingProcess.mode = MBProgressHUDMode.Text
                            loadingProcess.detailsLabelText = "Successfully updated"
                        }
                        else {
                            loadingProcess.mode = MBProgressHUDMode.Text
                            loadingProcess.detailsLabelText = "Not updated"
                        }
                   
//                    if(error != nil) {
//                        
//                        
//                        
//                        
//                        loadingProcess.mode = MBProgressHUDMode.Text
//                        
//                        loadingProcess.detailsLabelText = error!.localizedDescription
//                        //loadingProcess.hide(true, afterDelay: 5)
//                    }
//                    else {
//                        let resultString : NSData = NSKeyedArchiver.archivedDataWithRootObject(data!)
//                        completion(resultData: resultString)
//                        if( response?.statusCode == 200 ) {
//                          loadingProcess.mode = MBProgressHUDMode.Text
//                            loadingProcess.detailsLabelText = "Successfully updated"
//                        }
//                        else {
//                            loadingProcess.mode = MBProgressHUDMode.Text
//                            loadingProcess.detailsLabelText = "Not updated"
//                        }
//                    }
                    loadingProcess.hide(true, afterDelay: 2)
                   //MBProgressHUD.hideAllHUDsForView(self.window!, animated: true)
            }
        }
        else {
            
            Alamofire.request(.POST, url, parameters: param, encoding: .JSON, headers: headers)
                .responseJSON { request, response, data, error in
                    println(response)
                    if(error != nil) {
                        
                        let loadingProcess = MBProgressHUD.showHUDAddedTo(self.window!, animated: true)
                        loadingProcess.mode = MBProgressHUDMode.Text
                        
                        loadingProcess.detailsLabelText = error!.localizedDescription
                        loadingProcess.hide(true, afterDelay: 5)
                    }
                    else {
                        let resultString : NSData = NSKeyedArchiver.archivedDataWithRootObject(data!)
                        completion(resultData: resultString)
                    }
                    
            }
        }
    }
    
    // Image uploading
    
    func imageUploadingResult(data : NSData) -> NSString {
        var error : NSError?
        //var imageUploadingResultArray : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSDictionary
        let tempDict:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data)! as! NSDictionary
        var result : NSString = NSString()
        result = tempDict.valueForKey("message") as! NSString
        return result
    }
    
    // Calendar booking
    
//    func bookingResult(data : NSData) -> NSString {
//        var error : NSError?
//        //var imageUploadingResultArray : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSDictionary
//        let tempDict:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data)! as! NSDictionary
//        var result : NSString = NSString()
//        result = tempDict.valueForKey("status") as! NSString
//        return result
//    }
    
    // Sign up
    
    func signUpResult(data : NSData) -> NSArray {
        var error : NSError?
//        var tempDict : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSDictionary
        let tempDict:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data)! as! NSDictionary
        println(tempDict)
        var result : NSMutableArray = NSMutableArray()
        var tempResult:NSDictionary = tempDict as NSDictionary
        result.addObject(tempResult)
        if((result.valueForKey("error")) != nil) {
            //result = result.valueForKey("error") as! NSMutableArray
            return result
        }
        else {
            NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("email") as! NSString, forKey: "email")
            NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("archive") as! NSInteger, forKey: "archive")
            NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("created_at") as! NSString, forKey: "created_at")
            NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("encrypted_password") as! NSString, forKey: "encrypted_password")
            NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("id") as! NSNumber, forKey: "id")
            NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("remember_token") as! NSString, forKey: "remember_token")
            //NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("device_token") as! NSString, forKey: "device_token")
            NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("updated_at") as! NSString, forKey: "updated_at")
            //NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("name") as! NSString, forKey: "name")
            
            var authentication = NSUserDefaults.standardUserDefaults().objectForKey("remember_token") as! NSString
            return result
        }
        
        
    }
    
    // Get area list
    
    func getAreaArray(data : NSData) -> NSArray
    {
        var error : NSError?
        var areaListArray : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSArray
        var areaArray : NSMutableArray = NSMutableArray()
        for(var i = 0; i < areaListArray.count; i++)
        {
            var area : Area = Area()
            var tempDict : NSDictionary = areaListArray[i] as! NSDictionary
            //            venue.name = (tempDict.valueForKey("name")!)
            areaArray.addObject(tempDict)
            //areaArray.addObject(tempDict.valueForKey("id")!)
        }
        
        return areaArray
    }
    
    // Get venue type
    
    func getVanueArray(data : NSData) -> NSArray
    {
        var error : NSError?
        var venueListArray : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSArray
        var vanueArray : NSMutableArray = NSMutableArray()
        for(var i = 0; i < venueListArray.count; i++)
        {
            var venue : Venue = Venue()
            var tempDict : NSDictionary = venueListArray[i] as! NSDictionary
                       //venue.name = (tempDict.valueForKey("name")!)
            vanueArray.addObject(tempDict)
            //vanueArray.addObject(tempDict.valueForKey("name")!)
        }
        
        return vanueArray
    }
    
    // Get price ranhe
    
    func getPriceArray(data : NSData) -> NSArray
    {
        var error : NSError?
        var priceListArray : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSArray
        var priceArray : NSMutableArray = NSMutableArray()
        for(var i = 0; i < priceListArray.count; i++)
        {
            var price : Price = Price()
            var tempDict : NSDictionary = priceListArray[i] as! NSDictionary
            //            venue.name = (tempDict.valueForKey("name")!)
            priceArray.addObject(tempDict)
            //priceArray.addObject(tempDict.valueForKey("id")!)
        }
        return priceArray
    }
    
    func getSearchVenueArray(data : NSData) -> NSArray
    {
        var error : NSError?
        var searchVenueListArray : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSArray
        var searchVenueArray : NSMutableArray = NSMutableArray()
        for(var i = 0; i < searchVenueListArray.count; i++)
        {
            var searchVenue : SearchVenue = SearchVenue()
            var tempDict : NSDictionary = searchVenueListArray[i] as! NSDictionary
            var images : NSArray = tempDict.objectForKey("images") as! NSArray
            //println(tempDict)
            searchVenue.images = images
            //            venue.name = (tempDict.valueForKey("name")!)
            
            searchVenueArray.addObject(tempDict)
            //priceArray.addObject(tempDict.valueForKey("id")!)
        }
        //println(searchVenueArray)
        return searchVenueArray
    }
    
    // Get Login Details
    
    func getLoginDetailsArray(data : NSData) -> NSArray
    {
        var error : NSError?
        var loginDetailsListArray : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSDictionary
        var loginDetailsArray : NSMutableArray = NSMutableArray()

        var login : loginDetails = loginDetails()
        
        var tempDict : NSDictionary = loginDetailsListArray as NSDictionary
        
        login.archive = String((tempDict.valueForKey("archive") as! NSInteger))
        login.created_at = tempDict.valueForKey("created_at") as! NSString
        //login.device_token = tempDict.valueForKey("device_token") as! NSString
        login.email = tempDict.valueForKey("email") as! NSString
        login.encrypted_password = tempDict.valueForKey("encrypted_password") as! NSString
        login.id = String(tempDict.valueForKey("id") as! NSInteger)
        //login.name = tempDict.valueForKey("name") as! NSString
        login.remember_token = tempDict.valueForKey("remember_token") as! NSString
        login.updated_at = tempDict.valueForKey("updated_at") as! NSString
          
        loginDetailsArray.addObject(tempDict)
        
        // Session
        
        NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("email") as! NSString, forKey: "email")
        NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("archive") as! NSInteger, forKey: "archive")
        NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("created_at") as! NSString, forKey: "created_at")
        NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("encrypted_password") as! NSString, forKey: "encrypted_password")
        NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("id") as! NSNumber, forKey: "id")
        NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("remember_token") as! NSString, forKey: "remember_token")
        //NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("device_token") as! NSString, forKey: "device_token")
        NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("updated_at") as! NSString, forKey: "updated_at")
        //NSUserDefaults.standardUserDefaults().setObject(tempDict.valueForKey("name") as! NSString, forKey: "name")
        
        var authentication = NSUserDefaults.standardUserDefaults().objectForKey("remember_token") as! NSString
        return loginDetailsArray
    }
    
    // Get Property Details
    
    func getPropertyDetailsArray(data : NSData) -> NSArray
    {
        var error : NSError?
        var propertyDetailsListArray : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSArray
        var propertyDetailsArray : NSMutableArray = NSMutableArray()
        for(var i = 0; i < propertyDetailsListArray.count; i++)
        {
            
        //var login : loginDetails = loginDetails()
        var tempDict : NSDictionary = propertyDetailsListArray[i] as! NSDictionary
        //println(tempDict)
        
        propertyDetailsArray.addObject(tempDict)
            
        }
        return propertyDetailsArray
    }
    
    //Edit property details
    
    func getEditPropertyArray(data : NSData) -> NSArray
    {
        var error : NSError?
        var editPropertyListArray : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSDictionary
        var editPropertyArray : NSMutableArray = NSMutableArray()
        
            var EditProperty : editProperty = editProperty()
            var tempDict : NSDictionary = editPropertyListArray as NSDictionary
            var images : NSArray = tempDict.objectForKey("images") as! NSArray
            //println(tempDict)
            EditProperty.images = images
            //            venue.name = (tempDict.valueForKey("name")!)
            
            editPropertyArray.addObject(tempDict)
            //priceArray.addObject(tempDict.valueForKey("id")!)
        
        //println(searchVenueArray)
        return editPropertyArray
    }
    
    // Get calendar details
    
    func getCalendarDetailsArray(data : NSData) -> NSArray
    {
        var error : NSError?
        var calendarDetailsListArray : NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) as! NSArray
        var calendarDetailsArray : NSMutableArray = NSMutableArray()
        
        //var EditProperty : editProperty = editProperty()
        for(var i = 0; i < calendarDetailsListArray.count; i++)
        {
            
            //var login : loginDetails = loginDetails()
            var tempDict : NSDictionary = calendarDetailsListArray[i] as! NSDictionary
            
            calendarDetailsArray.addObject(tempDict)
            
        }
        return calendarDetailsArray
    }

}
