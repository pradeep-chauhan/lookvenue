//
//  RestApiManager.swift
//  lookvenue
//
//  Created by Pradeep Chauhan on 8/24/15.
//  Copyright (c) 2015 Pradeep Chauhan. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON,NSError?) -> Void

class RestApiManager:NSObject {
//    static let sharedInstance = RestApiManager()
//    let baseUrl="http://lookvenue.herokuapp.com/areas/get_areas_by_city_name?city_name=Delhi/NCR"
//    
//    func getJsonData(onComletion: (JSON) -> Void) {
//        makeHTTPGetRequest(baseUrl, onCompletion: { json, err -> Void in
//            onComletion(json)
//            
//        })
//    }
//    
//    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
//        let request = NSMutableURLRequest(URL:NSURL(string: path)!)
//        
//        let sesssion = NSURLSession.sharedSession()
//        
//        let task = sesssion.dataTaskWithRequest(request, completionHandler: { data, reponse, error
//             in
//            let json:JSON=JSON(data)
//            onCompletion(json,error)
//            
//            println(json)
//        })
//        task.resume()
//        
//    }
}
