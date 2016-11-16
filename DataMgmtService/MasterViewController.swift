//
//  MasterViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/14/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    // MARK: Properties
    var databases = [Database]()
    var selectedDB: Database?
   
    var tabBarViewController: UITabBarController? = nil
   
    override func viewDidLoad() {
        super.viewDidLoad()
       // loadSampleDatabases()
        CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!, viewController: self)
        loadDatabases()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.primaryOverlay
 
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.tabBarViewController = (controllers[controllers.count-1] ) as? UITabBarController
        }

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.tableView.bounds
       //  gradient.colors = [UIColor(red:146.0/255, green:141.0/255, blue:171.0/255, alpha:1).cgColor, UIColor(red:0.0/255, green:210.0/255, blue:255.0/255, alpha:1).cgColor]
        
         gradient.colors = [UIColor(red:200.0/255, green:227.0/255, blue:240.0/255, alpha:0.7).cgColor, UIColor(red:200.0/255, green:227.0/255, blue:240.0/255, alpha:0.7).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y :0)
        gradient.name = "masterTable"
        self.tableView.layer.insertSublayer(gradient, at: 0)
        
        //list all fonts
//        for name in UIFont.familyNames {
//            print(name)
//            if let nameString = name as? String
//            {
//                print(UIFont.fontNames(forFamilyName: nameString))
//            }
//        }
       // self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.5
        
        //let splitViewController = self.window!.rootViewController as! UISplitViewController
        self.splitViewController?.preferredPrimaryColumnWidthFraction = 0.37
        self.splitViewController?.maximumPrimaryColumnWidth = (self.splitViewController?.view.bounds.size.width)!
        
   Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(loadDatabases), userInfo: nil, repeats: true)
       // self.splitViewController?.minimumPrimaryColumnWidth = 500
        
    }
    
    func loadDatabases(){
        DatabaseModel.fetchDatabases(){ databases in
            self.databases = databases
            
            for db in databases {
               
                DatabaseModel.fetchWorks(clientId: db.clientId) { work in
                    
                    
                    if work != nil {
                        if db.id == (work?.instanceId)!{
                            db.workSubmitted = work
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
    
    
    
//    func loadSampleDatabases() {
//       // let oracle = UIImage(named: "oracle")!
//        let database1 = Database(name: "CRM_DB_DEV_TIM", type: "oracle_database", datasource: "CRM Data Source", expiresIn: "1 month 2 weeks 2 days")!
//        
//       // let mysql = UIImage(named: "mysql")!
//        let database2 = Database(name: "HCM_DB_DEV_SAM",type: "mysql_database", datasource: "HCM Data Source", expiresIn: "3 weeks 4 days")!
//        
//      //  let microsoftsqlserver = UIImage(named: "microsoftsqlserver")!
//        let database3 = Database(name: "SALES_DB_DEV_TIM", type: "microsoftsql_database", datasource: "Sales Data Source", expiresIn: "1 week 3 days")!
//        
//        let database4 = Database(name: "SALES_DB_DEV_BOB", type: "mysql_database", datasource: "Sales Data Source", expiresIn: "1 month 1 week 2 days")!
//        
//        databases += [database1, database2, database3, database4]
//    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTabDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selDB = databases[indexPath.row]
                self.selectedDB = selDB
                let navController = segue.destination as! UINavigationController
                navController.navigationBar.isHidden = true
                
                let tabController = (segue.destination as! UINavigationController).topViewController as! UITabBarController
                let summaryNavController = tabController.viewControllers?[0] as! UINavigationController
                let summaryController = (summaryNavController).topViewController as!  DbSummaryViewController
                summaryController.detailItem = selDB
                
                summaryController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                summaryController.navigationItem.leftItemsSupplementBackButton = true
                summaryController.navigationItem.title = selDB.name
                 
                let dataMgmtController = (tabController.viewControllers?[1] as! UINavigationController).topViewController  as! DataMgmtViewController
                dataMgmtController.detailItem = selDB
                dataMgmtController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                dataMgmtController.navigationItem.leftItemsSupplementBackButton = true
                dataMgmtController.navigationItem.title = selDB.name
                
//                let backupsController = (tabController.viewControllers?[2] as! UINavigationController).topViewController  as! BackupCollectionViewController
//                backupsController.detailItem = selDB
//                backupsController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
//                backupsController.navigationItem.leftItemsSupplementBackButton = true
//                backupsController.navigationItem.title = selDB.name
                
                let backupsTimelineController = (tabController.viewControllers?[2] as! UINavigationController).topViewController  as! BackupsTimelineViewController
                backupsTimelineController.detailItem = selDB
                backupsTimelineController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                backupsTimelineController.navigationItem.leftItemsSupplementBackButton = true
                backupsTimelineController.navigationItem.title = selDB.name

                let maskingViewController = (tabController.viewControllers?[3] as! UINavigationController).topViewController  as! MaskingViewController
                maskingViewController.detailItem = selDB
                maskingViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                maskingViewController.navigationItem.leftItemsSupplementBackButton = true
                maskingViewController.navigationItem.title = selDB.name
                
                    
                                       // self.performSegue(withIdentifier: "showOpDetails", sender: self)
                    
                
                 
            }
                    }
        else if segue.identifier == "showOpDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selDB = databases[indexPath.row]
                selectedDB = selDB
                var operation:Operation?
                
                        let restoreOperation = selectedDB?.latestRestoreOperation
                let backupOperation = selectedDB?.runningBackupOperation
                if(restoreOperation?.status == "1"){
                    operation = restoreOperation
                }
                else{ // backup operation
                    operation = backupOperation
                }
            let opStepsviewController =  (segue.destination as! UINavigationController).topViewController  as! OpearationStepsViewController
            
            opStepsviewController.operation = operation
                opStepsviewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                opStepsviewController.navigationItem.leftItemsSupplementBackButton = true
                //opStepsviewController.navigationItem.title = selectedDB.name
            }
            
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> DatabaseTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatabaseTableViewCell", for: indexPath) as! DatabaseTableViewCell

        cell.databaseName!.text = databases[indexPath.row].name
        if let dsName = databases[indexPath.row].datasource{
             cell.datasource!.text = "Using " + dsName
        }
        else{
            cell.datasource.isHidden = true
        }
        cell.typeImage!.image = databases[indexPath.row].typeImage
        //cell.expiresIn!.text = "Expires in " + databases[indexPath.row].expiresIn
        //cell.expiresIn!.textAlignment = .right
        // if databases[indexPath.row].latestRestoreOperation?.status == "1"  {
        if databases[indexPath.row].latestRestoreOperation?.status == "1"
        {
            cell.Status.isHidden = false
            cell.statusBtnText.isHidden = false
            cell.Status.setImage(UIImage(named:"gear"), for: .normal)
            CommonUtil.startRotating(duration:2, button: cell.Status)
            cell.statusBtnText.setTitle("Restore in Progress", for: .normal)

        }
        else if databases[indexPath.row].runningBackupOperation?.status == "1" {
            
            cell.Status.isHidden = false
            cell.statusBtnText.isHidden = false
            cell.Status.setImage(UIImage(named:"gear"), for: .normal)
            CommonUtil.startRotating(duration:2, button: cell.Status)
            //CommonUtil.rotateView(targetView: cell.Status, duration: 0.2)
            cell.statusBtnText.setTitle("Backup in Progress", for: .normal)
        }
        else if  let workSubmitted = databases[indexPath.row].workSubmitted {
            cell.Status.isHidden = false
            cell.statusBtnText.isHidden = false
            CommonUtil.stopRotating(button: cell.Status)
            cell.Status.setImage(UIImage(named:"scheduler_clock"), for: .normal)
            if(workSubmitted.type == "backup_database"){
                cell.statusBtnText.setTitle("Backup job submitted", for: .normal)
            }
            else{
                cell.statusBtnText.setTitle("Restore job submitted", for: .normal)
            }
        }
         else{
                      
            CommonUtil.stopRotating(button: cell.Status)
            
            cell.Status.isHidden = true
            cell.statusBtnText.isHidden = true
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            databases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red:76.0/255, green:162.0/255, blue:205.0/255, alpha:1)
        if databases[indexPath.row].latestRestoreOperation?.status != "1"{
         self.performSegue(withIdentifier: "showTabDetails", sender: self)
        }
        else{
            (selectedCell as? DatabaseTableViewCell)?.Status.isHidden = false
            self.performSegue(withIdentifier: "showOpDetails", sender: self)
        }
    }
    
    // if tableView is set in attribute inspector with selection to multiple Selection it should work.
    
    // Just set it back in deselect
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.clear
    }
 
    
   
    @IBAction func statusClicked(_ sender: Any) {
        print("Status Clicked.")
    }
    
    
    @IBAction func statusButtonTxtClicked(_ sender: Any) {
        
         self.performSegue(withIdentifier: "showOpDetails", sender: self)
        
    }
   
   
}

