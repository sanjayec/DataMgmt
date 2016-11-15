//
//  TableData.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/10/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class TableData{
    var name: String = ""
    var recordsInBackup1: Int = 0
    var recordsInBackup2: Int = 0
    var difference: Int = 0
    var percentageDifference: String = ""
    
    init(name: String, recordsInBackup1:Int, recordsInBackup2:Int){
        self.name = name
        self.recordsInBackup1 = recordsInBackup1
        self.recordsInBackup2 = recordsInBackup2
        
        
        self.difference = recordsInBackup2 - recordsInBackup1
        self.percentageDifference = String(format: "%.2f", 100.0 * Float(difference)/Float(recordsInBackup1) ) + "%"
        
    }
}
