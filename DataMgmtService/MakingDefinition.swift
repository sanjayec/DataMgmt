//
//  MakingDefinition.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/23/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


import UIKit

class MaskingDefinition {
    // MARK: Properties
    
    var name: String
    var description: String
    var dateCreated: Date
    var maskedColumns: Int
    
    
    // MARK: Initialization
    
    init(name: String, description:String, dateCreated: Date,maskedColumns: Int) {
        // Initialize stored properties.
        self.name = name
        self.description = description
        self.dateCreated = dateCreated
        self.maskedColumns = maskedColumns
        
}

}
