//
//  CompareResultsViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/10/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class CompareResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var backup1:Backup?
    var backup2:Backup?
    var dataChange = [TableData]()
    var schemaChange = [SchemaChangeTableRowData]()
    
    @IBOutlet weak var schemaChangeTable: UITableView!
    @IBOutlet weak var dataChangeTable: UITableView!
    @IBOutlet weak var timeDifference: UILabel!
    
    @IBOutlet weak var dataChangeBtn: UIButton!
    @IBAction func dataChangeAction(_ sender: Any) {
        
        dataChangeTable.isHidden = false
        schemaChangeTable.isHidden = true
         selectTab(selectedBtn:dataChangeBtn, otherBtn: schemaChangeBtn)

    }
    @IBOutlet weak var schemaChangeBtn: UIButton!
    @IBAction func schemaChangeAction(_ sender: Any) {
        dataChangeTable.isHidden = true
        schemaChangeTable.isHidden = false
         selectTab(selectedBtn:schemaChangeBtn, otherBtn: dataChangeBtn)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (backup1?.dateCreated)! > (backup2?.dateCreated)!{
            let tmpBackup = backup1
            backup1 = backup2
            backup2 = tmpBackup
        }
        self.timeDifference.text = (backup2?.name)! + " ( B1 ) is " + timeDifferenceString(startDate: (backup1?.dateCreated)!, endDate: (backup2?.dateCreated)!) + " newer than " + (backup1?.name)! + " ( B2 )"
        self.timeDifference.numberOfLines = 0
        self.timeDifference.lineBreakMode = .byWordWrapping

        dataChange = ResultsModel.fetchTableDataDifference()
        schemaChange = ResultsModel.fetchSchemaDifference()
        
        self.dataChangeTable.delegate = self
        self.dataChangeTable.dataSource = self
        
        self.schemaChangeTable.delegate = self
        self.schemaChangeTable.dataSource = self
        
addBottomBorderForGraphSection(tableView: dataChangeTable)
        
        // Do any additional setup after loading the view.
        
        setTabImage(btnSort: dataChangeBtn)
        setTabImage(btnSort: schemaChangeBtn)
        selectTab(selectedBtn:dataChangeBtn, otherBtn: schemaChangeBtn)
        
    }
    
    func selectTab(selectedBtn: UIButton, otherBtn: UIButton){
        selectedBtn.backgroundColor = UIColor(red:0.0/255, green:85.0/255, blue:142.0/255, alpha:1)
        otherBtn.backgroundColor = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        
        selectedBtn.setTitleColor(UIColor.white, for: .normal)
        otherBtn.setTitleColor(UIColor.darkGray, for: .normal)
    }

    
    func setTabImage(btnSort: UIButton){
        let spacing = CGFloat(5.0)
        btnSort.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0 ,bottom: 0,right: spacing)
      btnSort.titleEdgeInsets = UIEdgeInsets(top: 0,left: spacing, bottom: 0,right: 0)
        
        btnSort.layer.cornerRadius = 8
        btnSort.layer.borderWidth = 1
        btnSort.layer.borderColor = UIColor.black.cgColor
        
        
//        btnSort.frame =  CGRect(x:0, y:0, width:250, height:50)
//    btnSort.tintColor = UIColor.white
//    btnSort.setImage(UIImage(named:icon), for: .normal)
//    btnSort.imageEdgeInsets = UIEdgeInsets(top: 0,left: 10 ,bottom: 0,right: 210)
//    btnSort.titleEdgeInsets = UIEdgeInsets(top: 0,left: 50,bottom: 0,right: 0)
//    btnSort.setTitle(text, for: .normal)
//    btnSort.layer.borderWidth = 1.0
//    btnSort.backgroundColor = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
//    btnSort.layer.borderColor = UIColor.white.cgColor
   // btnSort.addTarget(self, action: Selector("showSortTbl"), forControlEvents: UIControlEvents.TouchUpInside)
   // self.view.addSubview(btnSort)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timeDifferenceString(startDate :Date, endDate: Date ) -> String {
        let secondsFromNowToFinish = endDate.timeIntervalSince(startDate)
        let weeks = Int(secondsFromNowToFinish / (3600*7*24))
        let days = Int((secondsFromNowToFinish - Double(weeks) * (3600*7*24)) / (3600*24))
        
        
        if weeks == 0 {
            return String(format: "%d days", weeks)
        }
        else if weeks == 1 && days != 0{
           return String(format: "%d week %d days", weeks, days)
        }
        else if weeks == 1 && days == 0{
            return String(format: "%d week", weeks, days)
        }
        else if days != 0{
            return String(format: "%d weeks %d days", weeks, days)
        }
        else {
            return String(format: "%d weeks", weeks, days)
        }
        
    }
    
    
    // MARK: - Table View
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dataChangeTable{
        return self.dataChange.count + 1 // One extra for header
        }
        else{
            return schemaChange.count + 1
        }
    }
    
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dataChangeTable{
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataChangeCell", for: indexPath) as! DataChangeTableViewCell
        
        if(indexPath.row == 0){
            cell.serialNumber.text = "Sl No"
            cell.tableName.text = "Table Name"
            cell.recordsInBackup1.text = "Records in B1"
            cell.recordsInBackup2.text = "Records in B2" 
            cell.difference.text = "Difference"
            cell.percentageDifference.text = "% Difference"
          //  cell.backgroundColor = UIColor(red:212.0/255, green:216.0/255, blue:221.0/255, alpha:1)
            cell.serialNumber.textAlignment = .center
            cell.tableName.textAlignment = .left
//            cell.recordsInBackup1.textAlignment = .left
//            cell.recordsInBackup2.textAlignment = .left
//            cell.difference.textAlignment = .center
//            cell.percentageDifference.textAlignment = .center
//            
            let semiBold = UIFont.systemFont(ofSize: 13, weight: UIFontWeightSemibold)
            cell.serialNumber.font = semiBold
            cell.tableName.font = semiBold
            cell.recordsInBackup1.font = semiBold
            cell.recordsInBackup2.font = semiBold
            cell.difference.font = semiBold
            cell.percentageDifference.font = semiBold


            cell.recordsInBackup1.numberOfLines = 0
            cell.recordsInBackup1.lineBreakMode = .byWordWrapping
            
            cell.recordsInBackup2.numberOfLines = 0
            cell.recordsInBackup2.lineBreakMode = .byWordWrapping
            
        }
        else{
            let actualIndex = indexPath.row - 1
        cell.serialNumber.text = String(indexPath.row)
        cell.tableName.text = dataChange[actualIndex].name
        cell.recordsInBackup1.text = String(dataChange[actualIndex].recordsInBackup1)
        cell.recordsInBackup2.text = String(dataChange[actualIndex].recordsInBackup2)
        cell.difference.text = String(dataChange[actualIndex].difference)
        cell.percentageDifference.text = dataChange[actualIndex].percentageDifference
            cell.backgroundColor = UIColor.clear
            
            let regular = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
            cell.serialNumber.font = regular
            cell.tableName.font = regular
            cell.recordsInBackup1.font = regular
            cell.recordsInBackup2.font = regular
            cell.difference.font = regular
            cell.percentageDifference.font = regular
            
        }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "schemaChangeCell", for: indexPath) as! SchemaChangeTableViewCell
            
            if(indexPath.row == 0){
                cell.serialNumber.text = "Sl No"
                cell.objectName.text = "Object Name"
                cell.objectType.text = "Object Type"
                cell.change.text = "Change"
               
              //  cell.backgroundColor = UIColor(red:212.0/255, green:216.0/255, blue:221.0/255, alpha:1)
                cell.serialNumber.textAlignment = .center
              
                let semiBold = UIFont.systemFont(ofSize: 13, weight: UIFontWeightSemibold)
                cell.serialNumber.font = semiBold
                cell.objectType.font = semiBold
                cell.objectName.font = semiBold
                cell.change.font = semiBold
                
                
                
            }
            else{
                let actualIndex = indexPath.row - 1
                cell.serialNumber.text = String(indexPath.row)
                cell.objectName.text = schemaChange[actualIndex].objectName
                cell.objectType.text = schemaChange[actualIndex].objectType
                cell.change.text = schemaChange[actualIndex].change
                
                cell.backgroundColor = UIColor.clear
                
                let regular = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
                cell.serialNumber.font = regular
                cell.objectType.font = regular
                cell.objectName.font = regular
                cell.change.font = regular
                
            }
            
            return cell
        }
        
    }
    
    
    func addTopBorderForGraphSection(tableView : UITableView){
        //left border
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.opacity = 0.5
        border.frame = CGRect(x:0, y:0, width: tableView.frame.size.width, height:3)
        border.shadowColor = UIColor.gray.cgColor
        border.shadowOffset = CGSize(width:5, height:5)
        border.shadowRadius = 5
        border.shadowOpacity = 1.0
        
        
        tableView.layer.addSublayer(border)
        
        
        
    }
    
    func addBottomBorderForGraphSection(tableView : UITableView){
        //left border
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.opacity = 0.5
        border.frame = CGRect(x:0, y:tableView.frame.size.height, width: tableView.frame.size.width, height:3)
        border.shadowColor = UIColor.gray.cgColor
        border.shadowOffset = CGSize(width:5, height:5)
        border.shadowRadius = 5
        border.shadowOpacity = 1.0
        
        
        tableView.layer.addSublayer(border)
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
