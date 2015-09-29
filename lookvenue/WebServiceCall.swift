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
 
    func apiCallRequest(methodType: String, urlRequest: String, completion: (resultData : NSData) -> ()) -> Void
    {
        var baseUrl: String! = "http://lookvenue.herokuapp.com/"
        var method: String! = methodType
        var parameter: String! = urlRequest
        var url: String = baseUrl + parameter
        
        //println(method)
        //println(url)
        if( method == "GET") {
            Alamofire.request(.GET, url)
                .response { request, response, data, error in
                    //println(request)
                    //println(response)
                    if(error != nil) {
                        println(error)
                    }
                    
                    
                }
                .response { request, response, data, error in
                    //println(data)
                   
                    completion(resultData: data!)
            }
        }
        else {
            Alamofire.request(.POST, url)
                .response { request, response, data, error in
                    println(request)
                    println(response)
                    println(error)
                }
                .responseJSON { request, response, data, error in
                    completion(resultData: data as! NSData)
 
            }
        }
    }
    
    
    
    
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

}
