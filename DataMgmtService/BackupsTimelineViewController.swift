//
//  BackupsTimelineViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/7/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class BackupsTimelineViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    
    
    @IBOutlet weak var selectedBackupView: BackupView!
    @IBOutlet weak var timeline: ISTimeline!
    var selectedBackup: Backup?
    
    @IBOutlet weak var selectedBackupName: UILabel!
    
         @IBOutlet weak var selectedBackupId: UILabel!
    @IBOutlet weak var backupCreatedOn: UILabel!
    @IBOutlet weak var backupStatus: UILabel!
    @IBOutlet weak var storageType: UILabel!
    @IBOutlet weak var storageLocation: UILabel!
    
    @IBOutlet weak var restorePointTime: UILabel!
    @IBOutlet weak var SCN: UILabel!
    @IBOutlet weak var archiveLogs: UILabel!
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
    
    func setCompareRegion(){
        self.compareItem1View.layer.borderWidth = 1
        self.compareItem1View.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
    
      
      //  self.compareItem1View.layer.borderColor = (UIColor(patternImage: UIImage(named: "dash")!)).cgColor
        self.compareItem2View.layer.borderWidth = 1
        self.compareItem2View.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
       
        
        self.compareItem1.lineBreakMode = .byWordWrapping
        self.compareItem1.numberOfLines = 0
        self.compareItem2.lineBreakMode = .byWordWrapping
        self.compareItem2.numberOfLines = 0
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)
   setCompareRegion()
       
        let green = UIColor.init(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
        
        let touchAction = { (point:ISPoint, _ sliderValue: Float) in
            print("point \(point.title)")
           // self.compareView.isHidden = true
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
            let point = ISPoint(title: title, description: backup.name
                , pointColor: pointColor, lineColor: lineColor, touchUpInside: touchAction, fill: fill, pointValue: pointValue, pointObject: backup)
            backupPoints.append(point)
        }
        
//        let myPoints = [
//            ISPoint(title: "06:46 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", pointColor: black, lineColor: black, touchUpInside: touchAction, fill: false),
//            ISPoint(title: "07:00 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr.", pointColor: black, lineColor: black, touchUpInside: touchAction, fill: false),
//            ISPoint(title: "07:30 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", pointColor: black, lineColor: black, touchUpInside: touchAction, fill: false),
//            ISPoint(title: "08:00 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.", pointColor: green, lineColor: green, touchUpInside: touchAction, fill: true),
//            ISPoint(title: "11:30 AM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", touchUpInside: touchAction),
//            ISPoint(title: "02:30 PM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", touchUpInside: touchAction),
//            ISPoint(title: "05:00 PM", description: "Lorem ipsum dolor sit amet.", touchUpInside: touchAction),
//            ISPoint(title: "08:15 PM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", touchUpInside: touchAction),
//            ISPoint(title: "11:45 PM", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam.", touchUpInside: touchAction)
//        ]
        
        timeline.contentInset = UIEdgeInsetsMake(10.0, 20.0, 10.0, 10.0)
        timeline.points = backupPoints
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setSelectedBackupDetails(point: ISPoint, sliderValue : Float){
        if(selectedBackup != nil){
        self.selectedBackupName?.text = self.selectedBackup?.name
        self.selectedBackupId?.text = self.selectedBackup?.id
        self.backupStatus?.text = self.selectedBackup?.status
        self.storageType?.text = self.selectedBackup?.storageType
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
        self.selectedBackupName2?.text = self.selectedBackup?.name
        self.selectedBackupId2?.text = self.selectedBackup?.id
        self.backupStatus2?.text = self.selectedBackup?.status
        self.storageType2?.text = self.selectedBackup?.storageType
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

     func addToCompareAction() {
        
        if numberOfSelects % 2 == 0 {
            if self.backup2ForCompare?.name != self.selectedBackup?.name{
            self.backup1ForCompare = self.selectedBackup
            self.compareItem1?.text = self.selectedBackup?.name
                numberOfSelects += 1
            }
        }
        else{
            if self.backup1ForCompare?.name != self.selectedBackup?.name{
            self.backup2ForCompare = self.selectedBackup
            self.compareItem2?.text = self.selectedBackup?.name
                numberOfSelects += 1
            }
        }
        
        
        
    }
    
    @IBAction func compareAction(_ sender: Any) {
//        self.compareView.isHidden = false
//        self.selectedBackupView.isHidden = true
//        self.backupPointView.isHidden = true
        let popover = self.storyboard?.instantiateViewController(withIdentifier: "compareBackupsPopup") as! CompareResultsViewController
        popover.modalPresentationStyle = UIModalPresentationStyle.popover
        popover.popoverPresentationController?.backgroundColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1.0)
        
        popover.popoverPresentationController?.delegate = self
        popover.popoverPresentationController?.sourceView = self.compareItem2View
       // popover.popoverPresentationController?.sourceRect = selectedCellSourceRect!
        popover.popoverPresentationController?.permittedArrowDirections = .any
        popover.preferredContentSize = CGSize(width: 750, height: 700)
        
        //get data
        popover.backup1 = backup1ForCompare
        popover.backup2 = backup2ForCompare
        
        
        self.present(popover, animated: true, completion: nil)

    }
    var backup1ForCompare:Backup?
    var backup2ForCompare:Backup?
    var numberOfSelects = 0
    
    @IBOutlet weak var selectedBackupName2: UILabel!
    @IBOutlet weak var selectedBackupId2: UILabel!
    @IBOutlet weak var backupCreatedOn2: UILabel!
    @IBOutlet weak var backupStatus2: UILabel!
    @IBOutlet weak var storageType2: UILabel!
    @IBOutlet weak var storageLocation2: UILabel!
    
    @IBOutlet weak var backupPointView: BackupView!
    
    
    @IBOutlet weak var compareItem1View: UIView!

    @IBOutlet weak var compareBtn: UIButton!
    @IBOutlet weak var compareItem2View: UIView!
    

    @IBOutlet weak var compareItem1: UILabel!
    @IBOutlet weak var compareItem2: UILabel!
    
    
    @IBOutlet weak var compareDriftImage: UIImageView!
    
    @IBAction func restoreAction(_ sender: Any) {
        showRestoreConfirmPopup()
    }
    
    @IBAction func pointInTimeRestore(_ sender: Any) {
        showRestoreConfirmPopup()
    }
    
    
    func showRestoreConfirmPopup() {
        let refreshAlert = UIAlertController(title: "Restore Database Confirmation", message: "Are you sure you want to restore the database ?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            DatabaseModel.submitRestore(database: self.detailItem!, backup: self.selectedBackup!){ message in
                if message == "succeeded" {
                    self.showJobSubmittedAlert()
                }
                else {
                    self.showFailedJobAlert(message: message)
                }
                
            }
            print("Restore Job Submitted")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancelled Job")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    func showJobSubmittedAlert() {
        let refreshAlert = UIAlertController(title: "Restore job submitted successfully", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Clicked on OK")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    func showFailedJobAlert(message: String?) {
        let refreshAlert = UIAlertController(title: "Unable to submit restore job", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Clicked on OK")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
}
