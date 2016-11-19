//
//  OpWorkArgument.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/17/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//



import UIKit

class OpWorkArgument {
    // MARK: Properties
    
    var id: String
    var name: String
    var value: String?
    
    
    // MARK: Initialization
    
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(id: String, name: String, value: String?) {
        // Initialize stored properties.
        self.id = id
        self.name = name
        self.value = value
        
        
    }
    
    
    init?(json: [String: Any]) throws {
        
        // Extract id
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }
        
        // Extract name
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        // Extract value
         let value = json["value"] as? String
        
        
        
        // Initialize properties
        self.id = id
        self.name = name
        self.value = value
       
    }
        
}

