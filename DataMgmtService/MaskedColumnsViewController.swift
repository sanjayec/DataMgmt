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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maskedColumns = MaskingModel.fetchMaskedColumns()
        MaskedColumnsTableView.dataSource = self
        MaskedColumnsTableView.delegate = self
        // Do any additional setup after loading the view.
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

}
