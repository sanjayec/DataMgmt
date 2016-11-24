//
//  MaskedColumn.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/23/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//


import UIKit

class MaskedColumn {
    // MARK: Properties
    
    var tableName: String
    var columnName: String
    var columnType: String
    var format: String
    
    
    // MARK: Initialization
    
    init(tableName: String, columnName:String, columnType: String,format: String) {
        // Initialize stored properties.
        self.tableName = tableName
        self.columnName = columnName
        self.columnType = columnType
        self.format = format
        
    }
    
}
