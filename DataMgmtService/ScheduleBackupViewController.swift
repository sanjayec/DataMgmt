//
//  ScheduleBackupViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/26/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class ScheduleBackupViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {

      var typePickerDataSource = ["Online", "Offline"]
    
     var scheduleTypePickerDataSource = ["Immediate", "Later"]
    
    var datePickerDataSource = ["Immediate", "Later"]


    @IBOutlet weak var backupName: UITextField!
    
    @IBOutlet weak var backupType: UIPickerView!
    
    @IBOutlet weak var tags: UITextField!
    
    @IBOutlet weak var scheduleType: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var activityIndicatorView: ActivityIndicatorView!

    var detailItem: Database? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            //navigationItem.title = detail.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       backupType.delegate = self
        backupType.dataSource = self
        scheduleType.delegate = self
        scheduleType.dataSource = self
        
        datePicker.isHidden = true
        datePicker.minimumDate = Date()
        self.activityIndicatorView = ActivityIndicatorView(title: "Submitting Backup Job...", center: self.view.center)

       // datePicker.addTarget(self, action: Selector("dataPickerChanged:"), for: UIControlEvents.valueChanged)

    }

    
    func datePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        var strDate = dateFormatter.string(from: datePicker.date)
        //dateLabel.text = strDate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == backupType{
            return typePickerDataSource.count
        }
        else {
            return scheduleTypePickerDataSource.count

        }
    }
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == backupType{
           // return typePickerDataSource[row]
        }
        else {
            //return scheduleTypePickerDataSource[row]
            if scheduleTypePickerDataSource[row] == "Later" {
                datePicker.isHidden = false
            }
            else{
                datePicker.isHidden = true
            }
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == backupType{
            return typePickerDataSource[row]
        }
        else {
            return scheduleTypePickerDataSource[row]
            
        }

    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        
        if pickerView == backupType{
            pickerLabel.text = typePickerDataSource[row]
        }
        else {
            pickerLabel.text = scheduleTypePickerDataSource[row]
            
        }

        
        // pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
        pickerLabel.font = UIFont(name: GlobalVariables.ProximaNovaRegular, size: 12) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        
      
        
        return pickerLabel
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.performSegue(withIdentifier: "goToBackupTimeline", sender: self)
        

    }
    @IBAction func submitAction(_ sender: Any) {
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
        
        DatabaseModel.submitBackup(database: self.detailItem!){ message in
            self.removeIndicator()
            self.splitViewController?.toggleMasterView()
            if message == "succeeded" {
                
                self.showJobSubmittedAlert()
            }
            else {
                self.showFailedJobAlert(message: message)
            }
            
        }
        print("Backup Job Submitted")
    }
    
    func showJobSubmittedAlert() {
        let refreshAlert = UIAlertController(title: "Backup job submitted successfully", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Clicked on OK")
            self.performSegue(withIdentifier: "goToBackupTimeline", sender: self)

            //   self.removeIndicator()
            // self.splitViewController?.toggleMasterView()
           // self.performSegue(withIdentifier: "showOpDetails", sender: self)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    func showFailedJobAlert(message: String?) {
        let refreshAlert = UIAlertController(title: "Unable to submit schedule job", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Clicked on OK")
            self.performSegue(withIdentifier: "goToBackupTimeline", sender: self)

            //  self.removeIndicator()
            //  self.splitViewController?.toggleMasterView()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func removeIndicator(){
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
        self.activityIndicatorView.getViewActivityIndicator().isHidden = true
        self.view.setNeedsDisplay()
    }
    
    

}
