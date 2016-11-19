//
//  Backup.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/23/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


import UIKit

class Backup {
    // MARK: Properties
    
    var name: String
    var dateCreated: Date
    var id: String
    var storageType: String
    var storageLocation: String?
    var status: String
    
    // MARK: Initialization
    
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init?(id : String, name: String, dateCreated: Date?, storageType: String, status: String) {
        // Initialize stored properties.
        self.id = id
        self.name = name
        self.dateCreated = dateCreated!
        self.storageType = storageType
        self.status = status
        
        // Initialization should fail if there is no name
        if name.isEmpty  {
            return nil
        }
        
    }

    
    init?(json: [String: Any]) throws {
        
        // Extract name
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        // Extract type
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }
        
        // Extract expiration date
        guard let creationDate = json["dateCreated"] as? String else {
            throw SerializationError.missing("dateCreated")
        }
        // Extract status
        guard let status = json["status"] as? String else {
            throw SerializationError.missing("status")
        }
        
        // Extract storage type
        guard let storageType = json["storageType"] as? String else {
            throw SerializationError.missing("storageType")
        }
        
        // Extract storage location
        guard let storageLocation = json["storageLocation"] as? String else {
            throw SerializationError.missing("storageLocation")
        }
        

        
        // Initialize properties
        self.name = name
        self.id = id
        //let dateString = "Thu, 22 Oct 2015 07:45:17 +0000"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
         self.dateCreated = dateFormatter.date(from: creationDate)!
        
        self.status = status
        self.storageType = storageType
        self.storageLocation = storageLocation

    }
    
    
    
}
