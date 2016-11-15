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
    

}
