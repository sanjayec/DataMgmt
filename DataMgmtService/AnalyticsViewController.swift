//
//  AnalyticsViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/22/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class AnalyticsViewController: UIViewController, UISearchBarDelegate , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultsTableView: UITableView!
    var resultsArray=[Operation]()
    var filtered=[Operation]()

    var searchActive : Bool = false
    
    var detailItem: Database? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)
    

        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder))  {
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search operations and analyze")
        }

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
    
    //MARK:  Table View Methods
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
      //  if(searchActive){
            return filtered.count
//        }
//        else{
//             return resultsArray.count
//        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var operation:Operation
        
       // if(searchActive){
            operation = self.filtered[indexPath.row]
//        }
//        else{
//            operation = self.resultsArray[indexPath.row]
//        }
        
        let cell  = (self.resultsTableView.dequeueReusableCell(withIdentifier: "operationCell") as! OperationTableViewCell)
        
        cell.name.text = operation.name
        cell.type.text = "Operation Type: " + operation.type
        var status = ""
        if(operation.status == "1"){
            status = "Running"
        }
        else if(operation.status == "5"){
            status = "Succeeded"
        }
        else {
            status = "Failed"
        }
        
        cell.status.text = "Status: " + status
        
//        let cal =  Calendar(identifier: .gregorian)
//       // let date1 = cal.date(from: DateComponents. operation.startTime)!
//
//         let timeOffset = operation.startTime.offset(from: Date())
//        
//        cell.time.text = timeOffset + " ago"
        
        
        
        let currentDateTime = Date()
        let offset = currentDateTime.offset(from: operation.startTime)
                
       cell.time.text = offset + " ago"
        cell.matchedText.numberOfLines = 2
        cell.matchedText.lineBreakMode = .byWordWrapping
        var tags: String?
        if(operation.name == "Backup database 2016-11-18 14:58:43.879047"){
          tags = "Tags: preUpgrade CRM V2.3.1, stable repos, post patch P176201"

            
        }
        if(operation.name == "Backup database 2016-11-21 14:36:46.087182"){
            tags = "Tags: postUpgrade CRM V2.3.1, Full Backup, Nov 2016. "
        }
        if tags != nil{
        let searchWordRange = (tags! as NSString).range(of: searchTextUsed, options: .caseInsensitive)
        
        let attributedString = NSMutableAttributedString(string: tags!, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 11)])
        
        attributedString.setAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 12), NSForegroundColorAttributeName : UIColor.darkText], range: searchWordRange)
        
        
        cell.matchedText.attributedText = attributedString
            tags = ""
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        let selectedCell = tableView.cellForRow(at: indexPath) as? OperationTableViewCell
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        self.resultsTableView.isHidden = false
        searchTopConstraint.constant = 0.0
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = resultsArray.filter({ (oper) -> Bool in
            var tmp = oper.name
            if tmp.range(of: searchText, options: .caseInsensitive) != nil{
                return true
            }
            
            tmp = oper.type
            if tmp.range(of: searchText, options: .caseInsensitive) != nil{
                return true
            }
            
          
            if "preUpgrade CRM V2.3.1, stable repos, post patch P176201".range(of: searchText, options: .caseInsensitive) != nil{
                if(oper.name == "Backup database 2016-11-18 14:58:43.879047"){
                    
                    return true
                }
            }
            
            if "postUpgrade CRM V2.3.1, Full Backup, Nov 2016".range(of: searchText, options: .caseInsensitive) != nil{
                if(oper.name == "Backup database 2016-11-21 14:36:46.087182"){
                    
                    return true
                }
            }
            
            
            return false
        })
        if(searchText == "" &&  filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        if(searchText == "") {
            searchActive = false
            }
        searchTextUsed = searchText
        self.resultsTableView.reloadData()
    }
    var searchTextUsed = ""
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if self.detailItem != nil {
             resultsArray = (self.detailItem?.operations)!
        }
        
        navigationItem.title = self.detailItem?.name
    }
    var selectedOp:Operation?
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "Show Details") { action, index in
            //print("more button tapped")
//            if(self.searchActive){
//                if(indexPath.row >= self.filtered.count){
//                   self.selectedOp = self.resultsArray[indexPath.row]
//                }
//                else {
                   self.selectedOp = self.filtered[indexPath.row]
//                }
            
//            }
//            else{
//                self.selectedOp = self.resultsArray[indexPath.row]
//            }
            
             self.performSegue(withIdentifier: "showOpDetails", sender: self)
        }
        more.backgroundColor = UIColor.lightGray
 
        return [more]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOpDetails" {

            let opStepsviewController =  (segue.destination as! UINavigationController).topViewController  as! OpearationStepsViewController
            
            opStepsviewController.operation = selectedOp
            
            opStepsviewController.navigationItem.leftBarButtonItem = self.tabBarController?.splitViewController?.displayModeButtonItem
            opStepsviewController.navigationItem.leftItemsSupplementBackButton = true
            
//            opStepsviewController.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Operations", style:.plain, target:nil, action:#selector(AnalyticsViewController.comeBack))
//
//            
//            AnalyticsViewController.opStepsviewController1 = opStepsviewController
//            opStepsviewController.navigationItem.leftBarButtonItem = opStepsviewController.navigationItem.backBarButtonItem
           
            
            
        }
    }
     @IBAction func unwindToOperations(segue: UIStoryboardSegue) {}
    
   static var opStepsviewController1: OpearationStepsViewController?
   static func comeBack(){
     AnalyticsViewController.opStepsviewController1?.navigationController?.popViewController(animated: true)
    }

}
