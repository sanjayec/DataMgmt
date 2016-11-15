//
//  DbSummaryViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/14/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class DbSummaryViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    // MARK: Properties
    
    @IBOutlet weak var mySqlView: UIView!
    
    @IBOutlet weak var oracleView: UIView!
    
    @IBOutlet weak var host: UILabel!
    @IBOutlet weak var socket: UILabel!
    @IBOutlet weak var port: UILabel!
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var compiledFor: UILabel!
    @IBOutlet weak var configurationFile: UILabel!
    @IBOutlet weak var runningSince: UILabel!
    
    
    @IBOutlet weak var performanceSchema: UILabel!
    @IBOutlet weak var threadPool: UILabel!
    @IBOutlet weak var memCachedPlugin: UILabel!
    @IBOutlet weak var semiSyncReplPlugin: UILabel!
    @IBOutlet weak var ssalAvailability: UILabel!
    @IBOutlet weak var pamAuthentication: UILabel!
    @IBOutlet weak var passwordValidation: UILabel!
    @IBOutlet weak var auditLog: UILabel!
    @IBOutlet weak var firewall: UILabel!
    @IBOutlet weak var firewallTrace: UILabel!
    
    @IBOutlet weak var perfSchemaImage: UIImageView!
    @IBOutlet weak var threadPoolImage: UIImageView!
    @IBOutlet weak var memCachedImage: UIImageView!
    @IBOutlet weak var semiSyncImage: UIImageView!
    @IBOutlet weak var ssaAvailImage: UIImageView!
    
    @IBOutlet weak var pamAuthImage: UIImageView!
    @IBOutlet weak var passwordValidImage: UIImageView!
    @IBOutlet weak var AudiLogImage: UIImageView!
    @IBOutlet weak var firewallImage: UIImageView!
    @IBOutlet weak var firewallTraceImage: UIImageView!
    
    @IBOutlet weak var baseDir: UILabel!
    @IBOutlet weak var dataDir: UILabel!
    @IBOutlet weak var diskSpaceInDataDir: UILabel!
    @IBOutlet weak var pluginsDir: UILabel!
    @IBOutlet weak var tmpDir: UILabel!
    
    @IBOutlet weak var errorLog: UILabel!
    @IBOutlet weak var generalLog: UILabel!
    @IBOutlet weak var slowQueryLog: UILabel!
    
    @IBOutlet weak var errorLogImage: UIImageView!
    @IBOutlet weak var generalLogImage: UIImageView!
    @IBOutlet weak var slowQueryImage: UIImageView!
    
    @IBOutlet weak var privatePassKeyImage: UIImageView!
    @IBOutlet weak var publicPassKeyImage: UIImageView!
    @IBOutlet weak var privatePassKey: UILabel!
    @IBOutlet weak var publicPassKey: UILabel!
    
    @IBOutlet weak var graphStack: UIStackView!
    
    @IBOutlet weak var mysqlGraphs: UIStackView!
    @IBOutlet weak var oracleGraphs: UIStackView!
    
    @IBOutlet weak var oracleRightTopStack: UIStackView!
    @IBOutlet weak var perfRightDownStack: UIStackView!
    
    @IBOutlet weak var dbImage: UIImageView!
    @IBOutlet weak var standyHeader: UILabel!
    
    @IBOutlet weak var standbyDetails: UILabel!
    
    @IBOutlet weak var socketOrconnectStringLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.colorMe(type: self.detailItem?.type)
        // Set Title
        title = "Summary"
        // Do any additional setup after loading the view.
        self.configureView()
        self.setContent()
        CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)
      
         addLeftBorderForGraphSection(stackView: self.graphStack)
        addLeftBorderForGraphSection(stackView: self.oracleGraphs)
        // addLeftBorderForGraphSection(stackView: self.perfRightDownStack)
    }
    
    func setContent(){
        
        let properties = self.detailItem?.properties
        let dateCreated = self.detailItem?.dateCreated
        
        if let hostname = properties?["hostname"]{
            self.host.text = hostname
        }
        if let socket = properties?["socket"]{
            self.socket.text = socket
        }
        
        if let port = properties?["port"]{
            self.port.text = port
        }
        
        if let version = (properties?["version"]) { //! + " " + (properties?["version_comment"])!
            self.version.text = version
            if let versionComment = properties?["version_comment"] {
                self.version.text =  version + " " + versionComment
            }
        }
        if let os = properties?["version_compile_os"]{
            self.compiledFor.text = os
            if let compileMachine = properties?["version_compile_machine"]{
                self.compiledFor.text = os + " " + compileMachine
            }
        }
        self.configurationFile.text = "unknown"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        if let dateCreated = self.detailItem?.dateCreated{
            self.runningSince.text = dateFormatter.string(from: dateCreated)
        }
        
        //        if let perfSchema = properties?["performance_schema"] {
        //        self.performanceSchema.text = perfSchema.lowercased()
        //        setImage(text: self.performanceSchema.text!, imageView: self.perfSchemaImage)
        //        }
        setUIValues(propName: "performance_schema",label: self.performanceSchema, imageView: self.perfSchemaImage)
        setUIValues(propName: "innodb_buffer_pool_dump_now",label: self.threadPool, imageView: self.threadPoolImage)
        setUIValues(propName: "locked_in_memory",label: self.memCachedPlugin, imageView: self.memCachedImage)
        setUIValues(propName: "sync_frm",label: self.semiSyncReplPlugin, imageView: self.semiSyncImage)
        setUIValues(propName: "have_ssl",label: self.ssalAvailability, imageView: self.ssaAvailImage)
        
        setUIValues(propName: "password_validation",label: self.passwordValidation, imageView: self.passwordValidImage)
        setUIValues(propName: "audit_log",label: self.auditLog, imageView: self.AudiLogImage)
        setUIValues(propName: "firewall",label: self.firewall, imageView: self.firewallImage)
        setUIValues(propName: "firewall_trace",label: self.firewallTrace, imageView: self.firewallTraceImage)
        
        if let propValue = self.detailItem?.properties["default_authentication_plugin"]{
            if(propValue == "pam_auth_password"){
                setUIValues(propValue: "on",label: self.pamAuthentication, imageView: self.pamAuthImage)
                
            }
            else{
                setUIValues(propValue: "off",label: self.pamAuthentication, imageView: self.pamAuthImage)
                
                
            }
        }
        //set server directory values
        if let basedir = self.detailItem?.properties["basedir"]{
            self.baseDir.text = basedir
        }
        if let datadir = self.detailItem?.properties["datadir"]{
            self.dataDir.text = datadir
        }
        if let basedir = self.detailItem?.properties["data_diskspace"]{
            self.diskSpaceInDataDir.text = basedir
        }
        else{
            self.diskSpaceInDataDir.text = "unable to retrieve"
        }
        if let plugin_dir = self.detailItem?.properties["plugin_dir"]{
            self.pluginsDir.text = plugin_dir
        }
        if let tmpdir = self.detailItem?.properties["tmpdir"]{
            self.tmpDir.text = tmpdir
        }
        if let errorlog = self.detailItem?.properties["log_error"]{
           // self.errorLogImage.image = #imageLiteral(resourceName: "ash_dot")
            if(errorlog == "OFF"){
               // self.errorLog.text = "off"
                
            }
            else{
                self.errorLog.text = "on  " + errorlog
                self.errorLogImage.image = #imageLiteral(resourceName: "green_dot")
            }
        }
        else{
            //self.errorLog.text = "off"
        }
        self.generalLogImage.image = #imageLiteral(resourceName: "ash_dot")
        if let generallog = self.detailItem?.properties["general_log"]{
           
            if(generallog == "OFF"){
                self.generalLog.text = "off"
                
            }
            else{
                self.generalLog.text = "on  " + generallog
                self.slowQueryImage.image = #imageLiteral(resourceName: "green_dot")
            }
        }
        else{
            self.generalLog.text = "off"
        }
         self.slowQueryImage.image = #imageLiteral(resourceName: "ash_dot")
        if let slow_query_log = self.detailItem?.properties["slow_query_log"]{
           
            if(slow_query_log == "OFF"){
                self.slowQueryLog.text = "off"
            }
            else{
                self.slowQueryLog.text = "on  " + slow_query_log
                self.slowQueryImage.image = #imageLiteral(resourceName: "green_dot")
            }
        }
        else{
            self.slowQueryLog.text = "off"
        }
        
        //set authentication
        if let sha256_private_key = self.detailItem?.properties["sha256_private_key"]{
            self.privatePassKeyImage.image = #imageLiteral(resourceName: "ash_dot")
            if(sha256_private_key == "OFF"){
                self.privatePassKey.text = "off"
            }
            else{
                self.privatePassKey.text = "on  " + sha256_private_key
                self.privatePassKeyImage.image = #imageLiteral(resourceName: "green_dot")
            }
        }
        else{
            self.privatePassKey.text = "n/a"
        }
        
        if let sha256_public_key = self.detailItem?.properties["sha256_public_key"]{
            self.publicPassKeyImage.image = #imageLiteral(resourceName: "ash_dot")
            if(sha256_public_key == "OFF"){
                self.publicPassKey.text = "off"
            }
            else{
                self.publicPassKey.text = "on  " + sha256_public_key
                self.publicPassKeyImage.image = #imageLiteral(resourceName: "green_dot")
            }
        }
        else{
            self.publicPassKey.text = "n/a"
        }
        
        
        
        
        if self.detailItem?.type == "mysql_database" {
            //            mySqlView.isHidden = false
            //            oracleView.isHidden = true
            
            mysqlGraphs.isHidden = false
            oracleGraphs.isHidden = true
            dbImage.image = #imageLiteral(resourceName: "mysql_server_5.7")
            standyHeader.text = "Replication Slave"
            standbyDetails.text = "This server is not a slave in a replication setup"
            socketOrconnectStringLabel.text = "Socket:"
            mysqlAvailServFeaturesStack.isHidden = false
            oracleServerFeaturesStack.isHidden = true
        }
        else{
            //            mySqlView.isHidden = true
            //            oracleView.isHidden = false
            
            mysqlGraphs.isHidden = true
            oracleGraphs.isHidden = false
            dbImage.image = #imageLiteral(resourceName: "oracle_11g")
            standyHeader.text = "Standy Details"
            standbyDetails.text = "This is not standy database"
            socketOrconnectStringLabel.text = "Connect String:"
            
            mysqlAvailServFeaturesStack.isHidden = true
            oracleServerFeaturesStack.isHidden = false
        }

    }
    func addLeftBorderForGraphSection(stackView : UIStackView){
        //left border
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.opacity = 0.1
        border.frame = CGRect(x:-20, y:100, width: 3, height:stackView.frame.size.height)
        border.shadowColor = UIColor.gray.cgColor
        border.shadowOffset = CGSize(width:5, height:5)
        border.shadowRadius = 5
        border.shadowOpacity = 1.0

        
        stackView.layer.addSublayer(border)
        
       

    }
    
    func setUIValues(propValue: String, label: UILabel, imageView: UIImageView){
        
            label.text = propValue.lowercased()
            setImage(text: label.text!, imageView: imageView)
        
    }

    func setUIValues(propName: String, label: UILabel, imageView: UIImageView){
        label.text = "n/a"
        
        if var propValue = self.detailItem?.properties[propName] {
            if propValue == "DISABLED"{
                propValue = "off"
            }
                
            else if propValue == "ENABLED"{
                propValue = "on"
            }
            label.text = propValue.lowercased()
                   }
        setImage(text: label.text!, imageView: imageView)

    }

    func setImage(text:String, imageView: UIImageView){
        if text == "on" {
            imageView.image = #imageLiteral(resourceName: "green_dot")
        }
        else{
            imageView.image = #imageLiteral(resourceName: "ash_dot")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // navigationItem.title = "One"
        navigationItem.title = self.detailItem?.name
    }
    
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var detailItem: Database? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
             navigationItem.title = self.detailItem?.name
           
          
            
            
        }
    }
    
  
    @IBOutlet weak var mysqlAvailServFeaturesStack: UIStackView!
    
    @IBOutlet weak var oracleServerFeaturesStack: UIStackView!
    
}
