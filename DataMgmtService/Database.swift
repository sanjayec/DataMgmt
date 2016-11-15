//
//  Database.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/14/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class Database {
    // MARK: Properties
    
    var name: String
    var type: String
    var typeImage: UIImage?
    var datasource: String?
    var dateCreated: Date?
    var expiresIn: String
    var backups = [Backup]()
    var operations = [Operation]()
    var restoreOperations = [Operation]()
    var latestRestoreOperation:  Operation?
    var runningBackupOperation : Operation?
    var properties = [String:String]()
    
    // MARK: Initialization
    
    init?(name: String,type: String, datasource: String, expiresIn: String) {
        // Initialize stored properties.
        self.name = name
        self.type = type
        self.datasource = datasource
        self.expiresIn = expiresIn
        setUIImageForDbType(dbtype: type)
        // Initialization should fail if there is no name
        if name.isEmpty  {
            return nil
        }
        
    }
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }
    func setUIImageForDbType(dbtype:String) {
        var uiImage : UIImage
        switch(dbtype) {
        case "mysql_database":
            uiImage = #imageLiteral(resourceName: "mysql")
        case "oracle_database":
            uiImage = #imageLiteral(resourceName: "oracle")
        case "microsoft_database":
            uiImage = #imageLiteral(resourceName: "microsoftsqlserver")
        default:
            uiImage = #imageLiteral(resourceName: "oracle")
            
        }
        self.typeImage = uiImage
    }
    
    
    init?(json: [String: Any]) throws {
        // Extract name
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        // Extract type
        guard let type = json["type"] as? String else {
            throw SerializationError.missing("type")
        }
        // Extract dateCreated
        guard let createdOn = json["dateCreated"] as? String else {
            throw SerializationError.missing("dateCreated")
        }
        
        // Extract expiration date
        guard let expirationDate = json["expirationDate"] as? String else {
            throw SerializationError.missing("expirationDate")
        }

        // Extract associated data source
          let associatedDataSourceJson = json["associatedDataSource"] as? [String: Any]
        if associatedDataSourceJson != nil{
        // Extract associated data source
        guard let dsName = associatedDataSourceJson?["name"] as? String else {
            throw SerializationError.missing("name in associatedDataSource")
        }
            self.datasource = dsName
            
            
            // Extract backupList
            guard let backups = associatedDataSourceJson?["backupList"] as? [Any] else {
                throw SerializationError.missing("backupList")
            }
            for case let backupJson in backups {
                if let backup = try? Backup(json: (backupJson as? [String:Any])!) {
               // self.backups.append(backup!)
                                   }
            }

            
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

        
        // Extract expiration date
        guard let operations = json["operations"] as? [Any] else {
            throw SerializationError.missing("operations")
        }
        for case let operationJson in operations {
            if let operation = try? Operation(json: (operationJson as? [String:Any])!) {
                self.operations.append(operation!)
                if(operation?.type == "Restore Database"){
                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
//                    restoreOperations.append(operation!)
                    if(latestRestoreOperation != nil){
                    if((latestRestoreOperation?.startTime)! < (operation?.startTime)!){
                        latestRestoreOperation = operation
                    }
                    }
                    else{
                        latestRestoreOperation = operation

                    }
                }
                
                // get running backup if any
                if(operation?.type == "Backup Database"){
                    if(operation?.percentageComplete != "100%"){
                        runningBackupOperation = operation
                    }
                    
                }
            }
        }
        
        if runningBackupOperation != nil{
            if let runningBackup = Backup(name: (runningBackupOperation?.name)!, dateCreated: runningBackupOperation?.startTime, storageType: "N/A", status: "Running"){
              //   self.backups.append(runningBackup)
            }
            
        }
        
        //sort backups date wise
        self.backups.sort{ $0.dateCreated > $1.dateCreated }
        
        //sort restore operations
        self.restoreOperations.sort{ $0.startTime > $1.startTime }
        

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.dateCreated = dateFormatter.date(from: createdOn)!
        
        // Initialize properties
        self.name = name
        self.expiresIn = "1 week 4 days"
        self.type = type
        setUIImageForDbType(dbtype: type)
        
        self.readProperties(properties: (json["properties"] as? [Any])!)

    }
    
    func readProperties(properties: [Any]){
        for prop  in properties{
            let property = prop as? [String: Any]
             let propName = property?["name"]  as? String
            let propValue = property?["value"] as? String
            
                   self.properties[propName!] = propValue
          
            
        }
        
    }
    
}
