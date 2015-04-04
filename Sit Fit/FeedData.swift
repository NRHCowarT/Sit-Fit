//
//  FeedData.swift
//  Sit Fit
//
//  Created by Nick Cowart on 2/3/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

let _mainData: FeedData = FeedData()

class FeedData: NSObject {
    
    
    var correctVenue:[AnyObject] = []

    var selectedVenue: [String:AnyObject]?
    var selectedSeat: PFObject?
    
    var feedItems: [PFObject] = []
    var myfeedItems: [PFObject] = []
    
    class func mainData() -> FeedData {
        
        return _mainData
    }
    
    func refreshFeedItems(completion: () -> () ){
        
        var feedQuery = PFQuery(className: "Seat")
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {

                self.feedItems = objects as [PFObject]
                

            }
            
            completion()
            
        }
    }
    
    func refreshMyFeedItems(completion:() -> () ) {
        
        
        var feedQuery = PFQuery(className: "Seat")
        
        feedQuery.whereKey("creator", equalTo: PFUser.currentUser())
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
        
        if objects.count > 0 {
        
        self.feedItems = objects as [PFObject]
        
        
        }
        
        completion()
        
        }
        
    }
    
}
