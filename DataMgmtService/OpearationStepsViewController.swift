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
    
    var displayArray = [TreeViewNode]()
    var indentation: Int = 0
    var nodes: [TreeViewNode] = []
    var data: [TreeViewData] = []
    
    var operation : Operation?
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var percentageCompleted: UILabel!
    var selectedCell: StepTableViewCell?
    
    
    //MARK:  Init & Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(OpearationStepsViewController.ExpandCollapseNode(_:)), name: NSNotification.Name(rawValue: "TreeNodeButtonClicked"), object: nil)
        
        data = TreeViewLists.LoadInitialData(operation: operation!)
        
        //for i in 0..<data.count
        //{
        //    let d: TreeViewData = data[i]
        //    print("\(d.name)")
        //}
        tableView.dataSource = self
        tableView.delegate = self
        
        nodes = TreeViewLists.LoadInitialNodes(data)
        
        self.LoadDisplayArray()
        self.tableView.reloadData()
        
       self.name.text = operation?.name
        self.type.text = operation?.type
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.startTime.text = dateFormatter.string(from: (operation?.startTime)!)
        if let endTIme = operation?.endTime{
         self.endTime.text = dateFormatter.string(from: endTIme)
        }
        if operation?.status == "0" {
        self.status.text = "Completed"
        }
        else if operation?.status == "5" {
            self.status.text = "Completed"
        }
        else {
            self.status.text = "Running"
        }
        
        self.percentageCompleted.text = operation?.percentageComplete
        
        
    }
    
    
    @IBAction func goBack(_ sender: Any) 
    {
        self.navigationController?.popViewController(animated: true)
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
        
        var colors:[Any]
        if (opStep.percentageComplete == "100%"){
            
            cell.setTheStatusIcon(UIImage(named: "green_tick")!)
            colors = [UIColor(red:0.0/255, green:210.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:58.0/255, green:123.0/255, blue:213.0/255, alpha:1).cgColor]
            
        }
        else if(opStep.percentageComplete == "0%"){
            
            colors = [UIColor(red:240.0/255, green:240.0/255, blue:240.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
            
        }
        else{
            cell.setTheStatusIcon(UIImage(named: "clock")!)
            colors = [UIColor(red:255.0/255, green:209.0/255, blue:148.0/255, alpha:1).cgColor, UIColor(red:112.0/255, green:225.0/255, blue:245.0/255, alpha:1).cgColor]
            
        }
        //addGradient(cell: cell, colors: colors)
        
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
            popover.step = selectedCell?.treeNode.nodeObject as? OperationStep
            popover.viewDidLoad()
            
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
