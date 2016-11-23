//
//  OpearationStepsViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/3/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class OpearationStepsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var refreshBtn: UIButton!
    var displayArray = [TreeViewNode]()
    var indentation: Int = 0
    var nodes: [TreeViewNode] = []
    var data: [TreeViewData] = []
    
    var operation : Operation?
    var database: Database?
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var percentageCompleted: UILabel!
    var selectedCell: StepTableViewCell?
    
    @IBOutlet weak var stepsHeader: UILabel!
    @IBOutlet weak var duration: UILabel!
    var activityIndicatorView: ActivityIndicatorView!
    
    //MARK:  Init & Load
    
    func goBack(){
        self.performSegue(withIdentifier: "goBackToOps", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if ( self.navigationController != nil ) {
        CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)
        }
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Operations", style:.plain, target:nil, action:#selector(goBack))
//   
//        self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem

        NotificationCenter.default.addObserver(self, selector: #selector(OpearationStepsViewController.ExpandCollapseNode(_:)), name: NSNotification.Name(rawValue: "TreeNodeButtonClicked"), object: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if operation !=  nil {
           data = TreeViewLists.LoadInitialData(operation: operation!)
        }
        
        //for i in 0..<data.count
        //{
        //    let d: TreeViewData = data[i]
        //    print("\(d.name)")
        //}
       
        
        nodes = TreeViewLists.LoadInitialNodes(data)
        
        self.LoadDisplayArray()
        self.tableView.reloadData()
        
       self.name.text = operation?.name
        self.type.text = operation?.type
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if (operation?.startTime != nil ) {
         self.startTime.text = dateFormatter.string(from: (operation?.startTime)!) + " UTC"
        }
        if let endTIme = operation?.endTime{
         self.endTime.text = dateFormatter.string(from: endTIme) + " UTC"
         duration.text =  CommonUtil.getDuration(date1: (operation?.startTime)!, date2: endTIme)

        }
        if operation?.status == "0" || operation?.status == "8" {
        self.status.text = "Not Started"
        }
        else if operation?.status == "5" {
            self.status.text = "Completed"
        }
        else if operation?.status == "1" {
            self.status.text = "Running"
        }
        setStepsHeader()
        
        self.percentageCompleted.text = operation?.percentageComplete
        
       
        self.navigationItem.title = operation?.name
        
        setRefreshButtonImage()
        
        Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(fetchOperation), userInfo: nil, repeats: true)

        var message = ""
        
        if(self.operation == nil ) {
            self.navigationItem.title = database?.name
            
            message = "Restore job is submitted for database " + (self.database?.name)! + ". Waiting for logs.."
            
            if  database?.workSubmitted?.restoretype == "associate_datasource" {
                message = "Associate job is submitted for database " + (self.database?.name)! + ". Waiting for logs.."
                
            }
         
            self.activityIndicatorView = ActivityIndicatorView(title: message, center: self.view.center, width: 1000, height:550, aplha: 0.92, vertical : true)

        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
        }
        else{
            if (self.activityIndicatorView != nil) {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
            }
        }
        
    }
    
    func setStepsHeader(){
        if self.operation?.type == "Backup Database"{
            stepsHeader.text = "Backup Steps"
        }
        else{
            stepsHeader.text = "Restore Steps"
        }
    }
    
    func setRefreshButtonImage(){
        
        self.refreshBtn.setImage(UIImage(named: "refresh_icon"), for: UIControlState.normal)
       
    }
    @IBAction func refreshAction(_ sender: Any) {
        fetchOperation()
    }
    
    func fetchOperation(){
        
        if(self.operation != nil){
        if self.operation?.status == "1"{
        DatabaseModel.fetchOperation(operationId: (self.operation?.id)!){ op in
            if(op != nil){
            self.operation = op
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.viewDidLoad()
                self.view.setNeedsDisplay()
                
            }
            
        }
        }
        }
        else{
             DatabaseModel.fetchDatabases(){ databases in
                for db in databases{
                    if db.id == self.database?.id {
                        self.database = db
                        if(db.latestRestoreOperation?.status == "1"){
                            self.operation = db.latestRestoreOperation
                            DispatchQueue.main.async {
                            self.viewDidLoad()
                            self.tableView.reloadData()
                            self.view.setNeedsDisplay()
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    func goBackToParent()
    {
      //  self.navigationController?.popViewController(animated: true)
        print("Inside GoBack Function")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:  Node/Data Functions
    
    func ExpandCollapseNode(_ notification: Notification)
    {
        self.LoadDisplayArray()
        self.tableView.reloadData()
    }
    
    
    func LoadDisplayArray()
    {
        self.displayArray = [TreeViewNode]()
        for node: TreeViewNode in nodes
        {
            self.displayArray.append(node)
            if (node.isExpanded == GlobalVariables.TRUE)
            {
                self.AddChildrenArray(node.nodeChildren as! [TreeViewNode])
            }
        }
    }
    
    func AddChildrenArray(_ childrenArray: [TreeViewNode])
    {
        for node: TreeViewNode in childrenArray
        {
            self.displayArray.append(node)
            if (node.isExpanded == GlobalVariables.TRUE )
            {
                if (node.nodeChildren != nil)
                {
                    self.AddChildrenArray(node.nodeChildren as! [TreeViewNode])
                }
            }
        }
    }
    
    //MARK:  Table View Methods
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let node: TreeViewNode = self.displayArray[indexPath.row]
        
        let cell  = (self.tableView.dequeueReusableCell(withIdentifier: "stepCell") as! StepTableViewCell)
        
        cell.treeNode = node
        let opStep = (node.nodeObject as! OperationStep)
        cell.treeLabel.text = opStep.name as String?
        
        if (node.isExpanded == GlobalVariables.TRUE)
        {
            cell.setTheButtonBackgroundImage(UIImage(named: "whiteOpen")!)
        }
        else
        {
            cell.setTheButtonBackgroundImage(UIImage(named: "whiteClose")!)
        }
        
        //var colors:[Any]
        if (opStep.status == "5"){
            CommonUtil.stopRotating( button: cell.statusIcon)

            
            // cell.statusIcon =
            cell.setTheStatusIcon(UIImage(named: "green_tick")!)
          //  colors = [UIColor(red:0.0/255, green:210.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:58.0/255, green:123.0/255, blue:213.0/255, alpha:1).cgColor]
            
            //removeAnimation(cell: cell)
            

        }
        else if(opStep.status == "1"){
            //removeAnimation(cell: cell)
            cell.setTheStatusIcon(UIImage(named: "clock")!)
           // cell.statusIcon.layer.removeAllAnimations()
           // stopRotating(button: cell.statusIcon)
            CommonUtil.startRotating(duration: 1, button: cell.statusIcon)
            
         //   colors = [UIColor(red:255.0/255, green:209.0/255, blue:148.0/255, alpha:1).cgColor, UIColor(red:112.0/255, green:225.0/255, blue:245.0/255, alpha:1).cgColor]
          
            
        }
        else{
            
           //   colors = [UIColor(red:240.0/255, green:240.0/255, blue:240.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
        }
        //addGradient(cell: cell, colors: colors)
        //cell.expand(nil)
        //set startDate/ endDate, Duration
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        
          cell.startDate.text = "Started: " + dateFormatter.string(from: opStep.startTime) + " UTC"
        if let endTime = opStep.endTime {
          cell.endDate.text = "Ended: " + dateFormatter.string(from: endTime) + " UTC"
          cell.duration.text = "Duration: " + CommonUtil.getDuration(date1: opStep.startTime, date2: endTime)
        }
        else{
          //  cell.duration.text = "Duration: " + CommonUtil.getDuration(date1: opStep.startTime, date2: Date())
            
        }
        
        
        
        cell.setNeedsDisplay()
        
        return cell
    }
    
  
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        for cell in tableView.visibleCells as! [StepTableViewCell]{
            cell.showLogsBtn.isHidden = true
        }
        
        selectedCell = tableView.cellForRow(at: indexPath) as? StepTableViewCell
        if(selectedCell?.treeNode.nodeChildren == nil){
           selectedCell?.showLogsBtn.isHidden = false
        }
        
       
    }
    
    func removeAnimation(cell: StepTableViewCell){
        cell.statusIcon.layer.removeAllAnimations()
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
    }
    
    @IBAction func showLogsAction(_ sender: Any) {
        
        
            let popover = self.storyboard?.instantiateViewController(withIdentifier: "logsPopup") as! LogsViewViewController
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
            popover.popoverPresentationController?.backgroundColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1.0)
            
            popover.popoverPresentationController?.delegate = self
            popover.popoverPresentationController?.sourceView = selectedCell
            popover.popoverPresentationController?.sourceRect = (selectedCell?.bounds)!
            popover.popoverPresentationController?.permittedArrowDirections = .unknown
        
        
            popover.preferredContentSize = CGSize(width: view.bounds.width-70, height: view.bounds.height-100)
           popover.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
            //map database object
            let opStep = (selectedCell?.treeNode.nodeObject as! OperationStep)

            popover.step = opStep
             popover.type = self.operation?.type
            popover.viewDidLoad()
        
//        let height = popover.logs.bounds.height
//        popover.preferredContentSize = CGSize(width: view.bounds.width-100, height: height)
//        

        
            
            self.present(popover, animated: true, completion: nil)
            }
    
    
    func addGradient(cell: UITableViewCell, colors: [Any]){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        
        
        gradient.colors = colors
        
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y :0)
        gradient.name = "gradient"
        let sublayer = cell.layer.sublayers?[0]
        
        if sublayer?.name == "gradient"{
            cell.layer.replaceSublayer(sublayer!, with: gradient)
        }
        
        cell.layer.insertSublayer(gradient, at: 0)
    }
    
    


}
