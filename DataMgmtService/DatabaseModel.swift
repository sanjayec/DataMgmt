    //
//  DatabaseModel.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/19/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//
import UIKit

class DatabaseModel {

    static let userPasswordString = "Bob:Bob"
   static func fetchDatabases(completionHandler: @escaping ([Database]) -> Void)  {
        let config = URLSessionConfiguration.default // Session Configuration
    
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: [])
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://52.53.155.179:8080/fws/instances")!
    
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            var databases = [Database]()

            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                   
                    if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                        for case let instance in json! {
                            if let db1 = try? Database(json: instance as! [String : Any]) {
                                databases.append(db1!)
                            }
                        }
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
           completionHandler(databases)
        })
        task.resume()
        
        
        
    }
    
    static func fetchDatasources(completionHandler: @escaping ([Datasource]) -> Void)  {
        let config = URLSessionConfiguration.default // Session Configuration
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: [])
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://52.53.155.179:8080/fws/datasources")!
        
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            var datasources = [Datasource]()
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                
                    if let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                        for case let instance in json! {
                            if let ds = try? Datasource(json: instance as! [String : Any]) {
                                datasources.append(ds!)
                            }
                        }
                    }
                    
                
                
                
            }
            completionHandler(datasources)
        })
        task.resume()
        
        
        
    }
    
    static func fetchWorks(clientId:String, completionHandler: @escaping (OpWork?) -> Void)  {
        let config = URLSessionConfiguration.default // Session Configuration
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: [])
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://52.53.155.179:8080/fws/workdepot/pull_works/" + clientId)!
        
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            var work : OpWork?
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                    for case let opWorkJson in json! {
                        if let operWork = try? OpWork(json: opWorkJson as! [String : Any]) {
                            work = operWork
                        }
                    }
                }                
            
                
                
                
            }
            completionHandler(work)
        })
        task.resume()
        
        
        
    }

    
    
    static func fetchOperation(operationId:String, completionHandler: @escaping (Operation?) -> Void)  {
        let config = URLSessionConfiguration.default // Session Configuration
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: [])
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://52.53.155.179:8080/fws/getOperationDefintions/" + operationId)!
        
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            var operation : Operation?
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? Any {
                    if let op = try? Operation(json: json as! [String : Any]) {
                       operation = op
                    }

                    
                }
                
                
                
                
            }
            completionHandler(operation)
        })
        task.resume()
        
        
        
    }
    
    static func submitRestore(database:Database, backup : Backup, completionHandler: @escaping (String?) -> Void)  {
        let url =  "http://52.53.155.179:8080/fws/workdepot/push_work"
        var status = "succeeded"
       // var json = NSMutableDictionary()
//        json.setValue("XXXXXX", forKey: "id")
//        json.setValue("restore_database", forKey: "type")
//        json.setValue(database.clientId, forKey: "clientId")
//        json.setValue(database.id, forKey: "instanceId")
//        json.setValue(nil, forKey: "submissionDate")
//        json.setValue(nil, forKey: "expiryDate")
//        json.setValue("8", forKey: "status")
//        json.setValue(nil, forKey: "opDefId")
//        json.setValue("1", forKey: "ownerId")
//        json.setValue(nil, forKey: "expiryDate")
//        json.setValue(nil, forKey: "expiryDate")
        
        
        let restoreProperty : [String : Any] = [
        "id": "8001",
        "name": "--restore_database"
       // "value": "" as AnyObject
        ]
        let databaseIdProperty : [String : Any] = [
            "id": "8002" ,
            "name": "--database_id" ,
            "value": database.id
        ]
        
        let backupIdProperty : [String : Any] = [
            "id": "8003" ,
            "name": "--back_up_id" ,
            "value": backup.id
        ]
        
        let json: [String: Any] = [
            "id": "XXXXXX"  ,
            "type": "restore_database" ,
            "clientId": database.clientId  ,
            "instanceId": database.id  ,
           // "submissionDate": ""  ,
           // "expiryDate": ""  ,
            "status": "8"  ,
            "ownerId": "1" ,
          //  "opDefId": ""  as AnyObject,
            "arguments":
                [
                    
                        restoreProperty,
                        databaseIdProperty,
                        backupIdProperty
                    
             ]
        ]
        
        let valid = JSONSerialization.isValidJSONObject(json) // true

        print("valid Json: " + String(valid))
        var data: Data?
        do{
             data = try? JSONSerialization.data(withJSONObject :json )
            
        } catch {
            status = "error in JSONSerialization"
            print("error in JSONSerialization")
            
        }
      
        
        HTTPPostJSON(url: url, data:data!) { (response, error) in
            print("Response: " + response )
            if error != nil {
                status =  error!
            }
             completionHandler(status)
        }
       
    }
    
       static func HTTPPostJSON(url: String,  data: Data,
                      callback: @escaping (String, String?) -> Void) {

       
        let url = URL(string: "http://52.53.155.179:8080/fws/workdepot/push_work")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        request.httpBody = data
        HTTPsendRequest(request: request, callback: callback)
        
        
    }

    
    static func HTTPsendRequest(request: URLRequest,
                         callback: @escaping (String, String?) -> Void) {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString(options: [])
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config) // Load configuration into Session
        
        
        let task = session.dataTask(with: request) {
                (responsedata, response, error) -> Void in
                if (error != nil) {
                    callback("", error?.localizedDescription)
                } else {
                    callback(String(data: responsedata!,
                                      encoding: String.Encoding.utf8)! as String, nil)
                }
        }
        
        task.resume()
    }
    

}
