//
//  Datasource.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/31/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


import UIKit

class Datasource {
    // MARK: Properties
    
    var name: String
    var type: String
    var release: String?
    var id: String?
    var owner: String?
    var storageType: String
    var backups = [Backup]()
    
    // MARK: Initialization
    
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init?(name: String, type: String, storageType: String, owner: String) {
        // Initialize stored properties.
        self.name = name
        self.type = type
        self.storageType = storageType
        self.owner = owner
        
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
        
        // Extract id
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }
        
        // Extract type
        guard let type = json["type"] as? String else {
            throw SerializationError.missing("type")
        }
        // Extract status
        guard let ownerName = json["ownerName"] as? String else {
            throw SerializationError.missing("ownerName")
        }
        
        // Extract storage type
        guard let storageType = json["storageType"] as? String else {
            throw SerializationError.missing("storageType")
        }
        
        // Extract storage location
        guard let release = json["release"] as? String else {
            throw SerializationError.missing("release")
        }
        
        // Extract backupList
        guard let backups = json["backupList"] as? [Any] else {
            throw SerializationError.missing("backupList")
        }
        for case let backupJson in backups {
            if let backup = try? Backup(json: (backupJson as? [String:Any])!) {
                self.backups.append(backup!)
                
            }
        }

        
        // Initialize properties
        self.name = name
        self.id = id
        self.type = type
        self.storageType = storageType
        self.owner = ownerName
        self.release = release
        
    }
    
    
    
}
