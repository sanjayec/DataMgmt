//
//  MaskedColumnsViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/23/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class MaskedColumnsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var MaskedColumnsTableView: UITableView!
    var maskedColumns = [MaskedColumn]()
    
    @IBOutlet weak var retentionView: UIView!
    @IBOutlet weak var dailyLabel: UILabel!
    
    @IBOutlet weak var dailySlider: UISlider!
    
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var weeklySlider: UISlider!
    @IBOutlet weak var weeks: UILabel!
    @IBOutlet weak var monthlySlider: UISlider!
    
    @IBOutlet weak var months: UILabel!
    @IBOutlet weak var yearlySlider: UISlider!
    @IBOutlet weak var years: UILabel!
    
    var policyType = "backup"
    override func viewDidLoad() {
        super.viewDidLoad()
        maskedColumns = MaskingModel.fetchMaskedColumns()
        MaskedColumnsTableView.dataSource = self
        MaskedColumnsTableView.delegate = self
        // Do any additional setup after loading the view.
        if (policyType == "backup"){
            retentionView.isHidden = false
            MaskedColumnsTableView.isHidden = true
            
        }
        else{
            retentionView.isHidden = true
            MaskedColumnsTableView.isHidden = false
        }
        
        setupSlider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var stepValue:Float = 1.0
    var lastQuestionStep:Float?
    func setupSlider()
    {
        // Set the initial value to prevent any weird inconsistencies.
       // self.lastQuestionStep = (self.dailySlider.value) / self.stepValue;
        addStyleToSlider(slider: dailySlider)
         addStyleToSlider(slider: weeklySlider)
         addStyleToSlider(slider: monthlySlider)
        addStyleToSlider(slider: yearlySlider)
        
        dailySlider.setValue(7.0, animated: false)
        weeklySlider.setValue(4.0, animated: false)
        monthlySlider.setValue(10.0, animated: false)
        yearlySlider.setValue(4.0, animated: false)
        
       setDailyText(newStep: dailySlider.value)
        
        weeks.text = "keeps 4 weeks"
        months.text = "keeps 10 months"
        years.text = "keeps 4 years"
        
        


   }
    func addStyleToSlider(slider:UISlider){
        slider.setThumbImage(UIImage(named: "thumb_slider_a"), for: .normal)
        
        slider.minimumTrackTintColor = UIColor.lightGray
        slider.maximumTrackTintColor = UIColor.lightGray
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return maskedColumns.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let maskingColumn  = self.maskedColumns[indexPath.row]
        
        
        let cell  = (self.MaskedColumnsTableView.dequeueReusableCell(withIdentifier: "maskedColumnCell") as! MaskedColumnTableViewCell)
        
        cell.tableName.text = maskingColumn.tableName
        cell.columnName.text = maskingColumn.columnName
        cell.columnType.text = maskingColumn.columnType
        cell.format.text = maskingColumn.format
        
        var fontStyle:UIFont?
        if(indexPath.row == 0){
             fontStyle = UIFont.systemFont(ofSize: 13, weight: UIFontWeightSemibold)
         }
        else{
             fontStyle = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)

        }
        
        cell.tableName.font = fontStyle
        cell.columnName.font = fontStyle
        cell.columnType.font = fontStyle
        cell.format.font = fontStyle
        
        return cell
    }
    
    @IBAction func onDailySliderChange(_ sender: Any) {
        let newStep = roundf((dailySlider.value) / self.stepValue)
        
        // Convert "steps" back to the context of the sliders values.
        self.dailySlider.value = newStep * self.stepValue;
        setDailyText(newStep: newStep)
          }
    
    func setDailyText(newStep: Float){
        var daysText = "days"
        if(newStep == 1){
            daysText = "day"
        }
        self.days.text = "Keeps " + String(Int(newStep)) + " " + daysText

    }
    @IBAction func onWeeklySliderChange(_ sender: Any) {
        let newStep = roundf((weeklySlider.value) / self.stepValue)

        // Convert "steps" back to the context of the sliders values.
        self.weeklySlider.value = newStep * self.stepValue;
        var weeksText = "weeks"
        if(newStep == 1){
            weeksText = "week"
        }
        self.weeks.text = "Keeps " + String(Int(newStep)) + " " + weeksText
    }
    
    
    @IBAction func onMonthlySliderChange(_ sender: Any) {
        let newStep = roundf((monthlySlider.value) / self.stepValue);
        
        // Convert "steps" back to the context of the sliders values.
        self.monthlySlider.value = newStep * self.stepValue
        var monthsText = "months"
        if(newStep == 1){
            monthsText = "month"
        }
        self.months.text = "Keeps " + String(Int(newStep)) + " " + monthsText
    }
    
    @IBAction func onYearlySliderChange(_ sender: Any) {
        let newStep = roundf((yearlySlider.value) / self.stepValue);
        
        // Convert "steps" back to the context of the sliders values.
        self.yearlySlider.value = newStep * self.stepValue;
        var yearsText = "years"
        if(newStep == 1){
            yearsText = "year"
        }
        self.years.text = "Keeps " + String(Int(newStep)) + " " + yearsText
    }

}
