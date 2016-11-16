//
//  OpWork.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/15/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


import UIKit

class OpWork {
    // MARK: Properties
    
    var id: String
    var type: String
    var clientId: String
    var instanceId: String
    var submissionDate: Date
    var expiryDate: Date?
    var status: String?
    var ownerId:String?
    
    
    // MARK: Initialization
    
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(id: String, type: String, clientId: String, instanceId: String, submissionDate:Date) {
        // Initialize stored properties.
        self.id = id
        self.type = type
        self.clientId = clientId
        self.instanceId = instanceId
        self.submissionDate = submissionDate
       
    }
    
    
    init?(json: [String: Any]) throws {
        
        // Extract id
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }
        
        // Extract type
        guard let type = json["type"] as? String else {
            throw SerializationError.missing("type")
        }
        
        // Extract clientId
        guard let clientId = json["clientId"] as? String else {
            throw SerializationError.missing("clientId")
        }
        // Extract instanceId
        guard let instanceId = json["instanceId"] as? String else {
            throw SerializationError.missing("instanceId")
        }
        
        // Extract submissionDate
        guard let submissionDate = json["submissionDate"] as? String else {
            throw SerializationError.missing("submissionDate")
        }
        
        // Extract status
        guard let status = json["status"] as? String else {
            throw SerializationError.missing("status")
        }
        
        
        
        // Initialize properties
        self.id = id
        self.type = type
        self.clientId = clientId
        self.instanceId = instanceId
        self.status = status
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.submissionDate = dateFormatter.date(from: submissionDate)!
        
        
    }
    
    
    
}
