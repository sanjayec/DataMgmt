//
//  Policy.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/26/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


import UIKit

class Policy {
    // MARK: Properties
    
    var name: String
    var description: String
    var dateModified: Date
    var customText: String
    var type:String
    
    
    // MARK: Initialization
    
    init(name: String, description:String, dateModified: Date,customText: String, type: String) {
        // Initialize stored properties.
        self.name = name
        self.description = description
        self.dateModified = dateModified
        self.customText = customText
        self.type = type
        
    }
    
}
