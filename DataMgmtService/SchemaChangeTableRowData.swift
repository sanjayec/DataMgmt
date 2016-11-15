//
//  SchemaChangeTableRowData.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/10/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class SchemaChangeTableRowData {
    var objectName: String = ""
    var objectType: String = ""
    var change: String = ""
    
    init(objectName: String, objectType:String, change:String){
        self.objectName = objectName
        self.objectType = objectType
        self.change = change
        
    }
}
