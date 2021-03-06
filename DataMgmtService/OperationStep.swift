//
//  OperationStep.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/25/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


import UIKit

class OperationStep {
    // MARK: Properties
    
    var name: String
    var id: String
    var startTime: Date
    var endTime: Date?
    var level: String
    var status: String?
    var percentageComplete: String
    var parentId: String?
    
    
    // MARK: Initialization
    
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init?(json: [String: Any]) throws {
        
        // Extract name
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        // Extract id
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }
        
        
        // Extract startTime
        guard let startTime = json["startTime"] as? String else {
            throw SerializationError.missing("startTime")
        }
        
        // Extract endTime
         let endTime = json["endTime"] as? String
        // Extract level
        guard let level = json["level"] as? String else {
            throw SerializationError.missing("level")
        }
        
        // Extract parentId
        guard let parentId = json["parentId"] as? String else {
            throw SerializationError.missing("parentId")
        }
        
        
        // Extract status
         let status = json["status"] as? String
        
        // Extract percentageComplete
        guard let percentageComplete = json["percentageComplete"] as? String else {
            throw SerializationError.missing("percentageComplete")
       }
      //  let startIndex = name.index(name.startIndex, offsetBy: 9)
       // self.name = name.substring(from: startIndex)
        self.name = name
        self.id = id
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.startTime = dateFormatter.date(from: startTime)!
        if(endTime != nil ){
            self.endTime = dateFormatter.date(from: endTime!)
        }
        self.parentId = parentId
        self.level = level
        self.status = status
        self.percentageComplete = percentageComplete
}

}
