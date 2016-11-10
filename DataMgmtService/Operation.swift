//
//  Operation.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/24/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//



import UIKit

class Operation {
    // MARK: Properties
    
    var name: String
    var id: String
    var type: String
    var startTime: Date
    var endTime: Date?
    var ownerId: String
    var status: String
    var percentageComplete: String
    var operationSteps = [OperationStep]()
    
    
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
        
        // Extract type
        guard let type = json["type"] as? String else {
            throw SerializationError.missing("type")
        }
        // Extract startTime
        guard let startTime = json["startTime"] as? String else {
            throw SerializationError.missing("startTime")
        }
        
        // Extract ownerId
        guard let endTime = json["ownerId"] as? String else {
            throw SerializationError.missing("endTime")
        }
        
        // Extract ownerId
        guard let ownerId = json["ownerId"] as? String else {
            throw SerializationError.missing("ownerId")
        }
        // Extract status
        guard let status = json["status"] as? String else {
            throw SerializationError.missing("status")
        }
        
        // Extract percentageComplete
        guard let percentageComplete = json["percentageComplete"] as? String else {
            throw SerializationError.missing("percentageComplete")
        }
        
        // Extract opInstances
        guard let opInstancesJson = json["opInstances"] as? [Any] else {
            throw SerializationError.missing("opInstances")
        }
        
        if opInstancesJson != nil{
            for case let opInstanceJson in opInstancesJson{
                if let opStep = try? OperationStep(json: opInstanceJson as! [String : Any]) {
                    self.operationSteps.append(opStep!)
                }
            }
            
            
            
        }
        
        //sort restore operations
        self.operationSteps.sort{ $0.startTime < $1.startTime }
        
        self.name = name
        self.id = id
        self.type = type
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.startTime = dateFormatter.date(from: startTime)!
        if(endTime != "" ){
          // self.endTime = dateFormatter.date(from: endTime.substring(to: endIndex))!
        }
        self.ownerId = ownerId
        self.status = status
        self.percentageComplete = percentageComplete
    }

        
}
