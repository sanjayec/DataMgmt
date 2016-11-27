//
//  CloneManagementViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/23/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class CloneManagementViewController: UIViewController, UIPopoverPresentationControllerDelegate{

    @IBOutlet weak var timeline: ISTimeline!
    @IBOutlet weak var selectedBackupView: BackupView!
    
    @IBOutlet weak var backupPointView: BackupView!
    @IBOutlet weak var restorePointTime: UILabel!
    @IBOutlet weak var SCN: UILabel!
    
    @IBOutlet weak var selectedBackupName: UILabel!
    
    @IBOutlet weak var selectedBackupId: UILabel!
    
    @IBOutlet weak var backupCreatedOn: UILabel!
    
    @IBOutlet weak var backupStatus: UILabel!
    @IBOutlet weak var storageType: UILabel!
    @IBOutlet weak var storageLocation: UILabel!
    @IBOutlet weak var archiveLogs: UILabel!
    
    @IBOutlet weak var selectedBackupName2: UILabel!
    
    @IBOutlet weak var selectedBackupId2: UILabel!
    
    @IBOutlet weak var backupCreatedOn2: UILabel!
    
    @IBOutlet weak var backupStatus2: UILabel!
    @IBOutlet weak var storageType2: UILabel!
    
    @IBOutlet weak var storageLocation2: UILabel!
    
    var selectedBackup: Backup?
    
    var detailItem: Database? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            navigationItem.title = detail.name
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ( self.navigationController != nil ) {
            CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)
        }
        
        let colors = [UIColor(red:200.0/255, green:216.0/255, blue:200.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
        
        
        addGradient(view: selectedBackupView,colors:colors)
        addGradient(view: backupPointView,colors:colors)
        selectedBackupView.layer.cornerRadius = 10.0
        backupPointView.layer.cornerRadius = 10.0
        
        let touchAction = { (point:ISPoint, _ sliderValue: Float) in
          //  print("point \(point.title)")
           //  self.compareView.isHidden = true
            self.selectedBackupView.isHidden = false
            self.selectedBackup = point.pointObject as? Backup
            
            if sliderValue == point.pointValue {
                self.backupPointView.isHidden = false
                self.selectedBackupView.isHidden = true
                self.setSelectedBackupPointDetails()
                
            }
            else{
                self.backupPointView.isHidden = true
                self.selectedBackupView.isHidden = false
                self.setSelectedBackupDetails(point: point,sliderValue: sliderValue)
                
            }
            
        }

        
       
        var backupPoints = [ISPoint]()
        var count = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        
        let backups = self.detailItem?.backups
        
        timeline.minimumValue=Float((backups?[(backups?.count)!-1].dateCreated.timeIntervalSince1970)!)
        timeline.maximumValue=Float((backups?[0].dateCreated.timeIntervalSince1970)!)
        timeline.sliderSelectAction = touchAction
        
        let green = UIColor.init(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)

        for backup in backups!{
            count += 1
            let title:String = dateFormatter.string(from: backup.dateCreated)
            let pointValue = Float(backup.dateCreated.timeIntervalSince1970)
            let pointColor = green
            var lineColor = UIColor.lightGray
            var fill = false
            fill = true
            if (count < 7){
                lineColor = green
                
            }
            var backuptype = "snap"
            let backupName = backup.name
            var snapshotName = backupName.replacingOccurrences(of: "Full backup", with: "Snapshot")
            
             snapshotName = snapshotName.replacingOccurrences(of: "Full_Backup", with: "Snapshot")


            let point = ISPoint(title: title, description: snapshotName
                , pointColor: pointColor, lineColor: lineColor, touchUpInside: touchAction, fill: fill, pointValue: pointValue, pointObject: backup, type: backuptype)
            backupPoints.append(point)
        }
  
        timeline.contentInset = UIEdgeInsetsMake(10.0, 20.0, 10.0, 10.0)
        timeline.points = backupPoints
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSelectedBackupDetails(point: ISPoint, sliderValue : Float){
        if(selectedBackup != nil){
            
            var snapshotName = self.selectedBackup?.name.replacingOccurrences(of: "Full backup", with: "Snapshot")
            
            snapshotName = snapshotName?.replacingOccurrences(of: "Full_Backup", with: "Snapshot")
            

            self.selectedBackupName?.text = snapshotName
            self.selectedBackupId?.text = self.selectedBackup?.id
            self.backupStatus?.text = self.selectedBackup?.status
            self.storageType?.text = "Nutanix/DSF" //self.selectedBackup?.storageType
            self.storageLocation?.text = self.selectedBackup?.storageLocation
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
            self.backupCreatedOn?.text = dateFormatter.string(from: (self.selectedBackup?.dateCreated)!) + " UTC"
            // Do any additional setup after loading the view.
            
            self.storageLocation.lineBreakMode = .byWordWrapping
            self.storageLocation.numberOfLines = 0
            
            //set restore point details
            let date = Date(timeIntervalSince1970: TimeInterval(sliderValue))
            self.restorePointTime.text = dateFormatter.string(from: date)
            var scnstrString = String(sliderValue)
            
            let newStartIndex = scnstrString.index(scnstrString.startIndex, offsetBy: 2)
            let newEndIndex = scnstrString.index(scnstrString.endIndex, offsetBy: -4)
            scnstrString = scnstrString.substring(to: newEndIndex)
            scnstrString = scnstrString.substring(from: newStartIndex)
            
            self.SCN.text = scnstrString
            self.archiveLogs.text =  "archive_logs_09_10_Seq1.log, archive_logs_19_10_Seq2.log, archive_logs_20_10_Seq3.log, archive_logs_21_10_Seq4.log"
            self.archiveLogs.lineBreakMode = .byWordWrapping
            self.archiveLogs.numberOfLines = 0
            
            addToCompareAction()
        }
        
        
    }

    func setSelectedBackupPointDetails(){
        
        var snapshotName = self.selectedBackup?.name.replacingOccurrences(of: "Full backup", with: "Snapshot")
        
        snapshotName = snapshotName?.replacingOccurrences(of: "Full_Backup", with: "Snapshot")
        

        
        self.selectedBackupName2?.text = snapshotName
        self.selectedBackupId2?.text = self.selectedBackup?.id
        self.backupStatus2?.text = self.selectedBackup?.status
        self.storageType2?.text = "Nutanix/DSF" //self.selectedBackup?.storageType
        self.storageLocation2?.text = self.selectedBackup?.storageLocation
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        self.backupCreatedOn2?.text = dateFormatter.string(from: (self.selectedBackup?.dateCreated)!) + " UTC"
        
        self.storageLocation2.lineBreakMode = .byWordWrapping
        self.storageLocation2.numberOfLines = 0
        addToCompareAction()
        
        if(self.selectedBackup?.status == "Running"){
            let popover = self.storyboard?.instantiateViewController(withIdentifier: "backupProgressPopup") as! BackupProgressViewController
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
            popover.popoverPresentationController?.backgroundColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1.0)
            
            popover.popoverPresentationController?.delegate = self
            popover.popoverPresentationController?.sourceView = self.selectedBackupView
            popover.popoverPresentationController?.sourceRect = self.selectedBackupView.bounds
            popover.popoverPresentationController?.permittedArrowDirections = .any
            popover.preferredContentSize = CGSize(width: 1200, height: 160)
            
            //map database object
            popover.detailItem = self.detailItem
            
            self.present(popover, animated: true, completion: nil)
        }
        else{
            addToCompareAction()
        }
    }
    
    func addGradient(view: UIView, colors: [Any]){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        
        
        gradient.colors = colors
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y :0)
        gradient.name = "gradient"
        let sublayer = view.layer.sublayers?[0]
        
        if sublayer?.name == "gradient"{
            view.layer.replaceSublayer(sublayer!, with: gradient)
        }
        
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func addToCompareAction() {
        
//        if numberOfSelects % 2 == 0 {
//            if self.backup2ForCompare?.name != self.selectedBackup?.name{
//                self.backup1ForCompare = self.selectedBackup
//                self.compareItem1?.text = self.selectedBackup?.name
//                numberOfSelects += 1
//            }
//        }
//        else{
//            if self.backup1ForCompare?.name != self.selectedBackup?.name{
//                self.backup2ForCompare = self.selectedBackup
//                self.compareItem2?.text = self.selectedBackup?.name
//                numberOfSelects += 1
//            }
//        }
//        
        
        
    }
    
    @IBOutlet weak var cloneAction1: UIButton!
    @IBAction func cloneAction(_ sender: Any) {
        
        showCloneActionPopup(sender)
    }
    
    @IBAction func cloneAction2(_ sender: Any) {
        showCloneActionPopup(sender)

    }
    
    func showCloneActionPopup(_ sender: Any){
        let popover = self.storyboard?.instantiateViewController(withIdentifier: "CloneActions") as! CloneActionsViewController
        popover.modalPresentationStyle = UIModalPresentationStyle.popover
        popover.popoverPresentationController?.backgroundColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1.0)
        
        popover.popoverPresentationController?.delegate = self
        popover.popoverPresentationController?.sourceView = (sender as! UIView)
        popover.popoverPresentationController?.sourceRect = (sender as! UIView).bounds
        popover.popoverPresentationController?.permittedArrowDirections = .any
        popover.preferredContentSize = CGSize(width: 230, height: 190)
        
        
        
        self.present(popover, animated: true, completion: nil)
    }

}
