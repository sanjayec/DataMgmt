//
//  MaskingViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/13/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class MaskingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var maskingTableView: UITableView!
    var policyDefs = [Policy]()
    override func viewDidLoad() {
        super.viewDidLoad()
      //  title = "Masking/Subsetting"
        CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)

        maskingTableView.delegate = self
        maskingTableView.dataSource = self
    
        policyDefs = MaskingModel.fetchPolicies()
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
                 return policyDefs.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let policy  = self.policyDefs[indexPath.row]
       
        
        let cell  = (self.maskingTableView.dequeueReusableCell(withIdentifier: "maskingDefCell") as! MaskingTableViewCell)
        
        cell.name.text = policy.name
        cell.desc.text = policy.description
        cell.maskedColumns.text =  policy.customText
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        cell.dateCreated.text = dateFormatter.string(from: policy.dateModified) + " UTC"
        
        return cell
    }
    
    //var selectedCell: MaskingTableViewCell?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
         let selectedCell = maskingTableView.cellForRow(at: indexPath) as? MaskingTableViewCell
        
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "Show Details") { action, index in
            //print("more button tapped")
            let popover = self.storyboard?.instantiateViewController(withIdentifier: "MaskedColumnsView") as! MaskedColumnsViewController
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
           // popover.popoverPresentationController?.backgroundColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1.0)
            
            let selectedCell = self.maskingTableView.cellForRow(at: indexPath) as? MaskingTableViewCell

            
            popover.popoverPresentationController?.delegate = self
            popover.popoverPresentationController?.sourceView = selectedCell
            popover.popoverPresentationController?.sourceRect = CGRect(x:self.view.bounds.midX + 125, y:self.view.bounds.midY-150,width:0,height:0) //CGRect(x: 1000, y: (selectedCell?.frame.origin.y)!, width: 10, height: 10)
            
            popover.popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
            
            let policy = self.policyDefs[indexPath.row]
            
            popover.policyType = policy.type
            
            if(policy.type == "backup"){
                popover.preferredContentSize = CGSize(width: 600, height: 400)

            }
            else{
                popover.preferredContentSize = CGSize(width: 800, height: 700)

            }
            
            self.present(popover, animated: true, completion: nil)
            
        }
        more.backgroundColor = UIColor.lightGray
        
        return [more]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }

}
