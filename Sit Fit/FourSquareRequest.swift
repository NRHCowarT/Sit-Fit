//
//  FourSquareRequest.swift
//  maps
//
//  Created by Nick Cowart on 2/2/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit
import CoreLocation

let API_URL = "https://api.foursquare.com/v2/"
let CLIENT_ID = "LDMRLGTVAXQZSSAAIRMV4A5CF2IDMTBMZ5JQ4WMT4KXKI4GF"
let CLIENT_SECRET = "EALR0EDCPVS52NXII1T4NNOSOEBRJF55OTE1R33YSR3WQ2P2"


class FourSquareRequest: NSObject {
    
    class func requestVenuesWithLocation(location: CLLocation) -> [AnyObject] {
        
        let requestString = "\(API_URL)venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
//        println(requestString)
        
        if let url = NSURL(string: requestString){
            
            let request = NSURLRequest(URL: url)
            
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
            
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject]{
                    
                    let responseInfo = returnInfo["response"] as [String:AnyObject]
                    
                    let venues = responseInfo["venues"] as [AnyObject]
                    
                    return venues
                    
                }
                
            }
            
        }
        
        
        return []
        
        }
   
}
