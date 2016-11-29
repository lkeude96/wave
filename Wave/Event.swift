//
//  Event.swift
//  Wave
//
//  Created by Eude Lesperance on 11/25/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import Foundation
import Firebase

struct Event {
    let key: String
    
    let itemRef: FIRDatabaseReference?
    
    let thumbnailImageName: String
    let eventName: String
    let eventDate: String
    let eventCost: Double
    let createdBy: String
    let eventLocation: String
    
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        self.itemRef = snapshot.ref
        
        self.thumbnailImageName = "event"
        
        guard let value = snapshot.value as? [String: AnyObject] else {
            self.eventName = ""
            self.eventDate = ""
            self.eventCost = 0.0
            self.createdBy = ""
            self.eventLocation = ""
            
            return
        }
        
        
        self.eventName = value["eventName"] as? String ?? ""
        self.eventDate = value["eventDate"] as? String ?? ""
        self.eventCost = value["eventCost"] as? Double ?? 0
        self.eventLocation = value["eventLocation"] as? String ?? ""
        self.createdBy = value["createdBy"] as? String ?? ""
        
        
    }
    
    init(key: String = "", eventName: String, eventCost: Double, eventDate: String, eventLocation: String = "TBD", createdBy: String) {
        self.key = key
        
        self.itemRef = nil
        
        self.thumbnailImageName = "event"
        self.eventName = eventName
        self.eventCost = eventCost
        self.eventDate = eventDate
        self.eventLocation = eventLocation
        self.createdBy = createdBy
        
    }
    
    func toJSONDict() -> [String: AnyObject] {
        return [
            "eventName": self.eventName as AnyObject,
            "eventDate": self.eventDate as AnyObject,
            "eventCost": self.eventCost as AnyObject,
            "eventLocation": self.eventLocation as AnyObject,
            "createdBy": self.createdBy as AnyObject
            
        ]
    }
}
