//
//  DataMgmtViewController
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/14/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class DataMgmtViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITabBarDelegate{

    
    let stepReuseIdentifier = "Cell"
    let restoreOpReuseId = "RestoreOpCell"
    // MARK : Properties
  
   
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var progressStepsCollection: UICollectionView!
    @IBOutlet weak var restoreOpsCollection: UICollectionView!
    
    @IBOutlet weak var logsView: UIView!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var showOps: UIButton!
    var lastCellSelected: OperationCollectionViewCell?
    
    @IBAction func startCount(_ sender: UIButton) {
        progressLabel.text = "0%"
        self.counter = 0
        for _ in 0..<100 {
            DispatchQueue.global(qos: .userInitiated).async {
                sleep(1)
                DispatchQueue.main.async {
                    self.counter += 1
                    return
                }
            }
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
           
                   }
        
        navigationItem.title = self.detailItem?.name
    }
    override func viewWillAppear(_ animated: Bool) {
        // navigationItem.title = "One"
        navigationItem.title = self.detailItem?.name

    }

    @IBAction func showOps(_ sender: AnyObject) {
        self.restoreOpsCollection.isHidden = !self.restoreOpsCollection.isHidden
        if(self.restoreOpsCollection.isHidden){
            showOps.setTitle("Show All", for: .normal)
        }
        else{
            showOps.setTitle("Hide All", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set Title
        title = "Data Management"
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        progressStepsCollection.dataSource = self
        progressStepsCollection.delegate = self
        
        restoreOpsCollection.dataSource = self
        restoreOpsCollection.delegate = self
        
        progressStepsCollection.backgroundColor = UIColor.white
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = restoreOpsCollection.bounds
         gradient.colors = [UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y :0)
        let vv = UIView()
        restoreOpsCollection.backgroundView = vv;
        restoreOpsCollection.backgroundView?.layer.insertSublayer(gradient, at: 0)
        
        //restoreOpsCollection.backgroundColor = UIColor.white
        
        if let restoreProgressStr = self.detailItem?.latestRestoreOperation?.percentageComplete {
        let endIndex = restoreProgressStr.index((restoreProgressStr.startIndex), offsetBy: ((restoreProgressStr.characters.count)-1))

          
        let fractionalProgress = Float(restoreProgressStr.substring(to: endIndex))! / 100.0
        progressView.setProgress(fractionalProgress, animated: true)
        progressLabel.text = restoreProgressStr
            
            tabBar.selectedItem = (tabBar.items?[1])! as UITabBarItem
            tabBar.delegate = self
        
        }
        
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Database? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            
            progressView.setProgress(fractionalProgress, animated: animated)
            progressLabel.text = ("\(counter)%")
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == progressStepsCollection {
        if let count =  (self.detailItem?.latestRestoreOperation?.operationSteps.count){
            return count
        }
        }
        else {
            if let count =  (self.detailItem?.restoreOperations.count){
                return count
            }
        }
        return 0
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        if collectionView == restoreOpsCollection {

        if let indexPath = collectionView.indexPathsForSelectedItems{
            let selectedCell = collectionView.cellForItem(at: indexPath[0])
            let selectedCellSourceRect = selectedCell?.bounds
            let restoreOp =  self.detailItem?.restoreOperations[indexPath[0].row]
            
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = (selectedCell?.bounds)!
            gradient.colors = [UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1).cgColor, UIColor(red:142.0/255, green:158.0/255, blue:171.0/255, alpha:1).cgColor]
            gradient.startPoint = CGPoint.zero
            gradient.endPoint = CGPoint(x: 1,y :0)
            
            selectedCell?.layer.insertSublayer(gradient, at: 0)
            lastCellSelected?.layer.sublayers?[0].removeFromSuperlayer()
            lastCellSelected = selectedCell as! OperationCollectionViewCell?
            
            self.detailItem?.latestRestoreOperation = restoreOp
            //self.logsView.viewDidLoad()
//            self.logsView.setNeedsDisplay()
//            self.logsView.setNeedsLayout()
//            self.viewDidLoad()
//            self.viewWillAppear(true)
            
            
            self.view.setNeedsDisplay()
            self.progressStepsCollection.reloadData()
            self.progressStepsCollection.setNeedsDisplay()
            self.progressStepsCollection.setNeedsLayout()
            self.viewDidLoad()
            self.viewWillAppear(true)
        }
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == progressStepsCollection {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stepReuseIdentifier, for: indexPath as IndexPath) as! RestoreProgressCollectionViewCell
        let opStep = self.detailItem!.latestRestoreOperation?.operationSteps[indexPath.item]
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
       
        
        if (opStep?.percentageComplete == "100%"){
           // cell.backgroundColor = UIColor(red:22.0/255, green:191.0/255, blue:253.0/255, alpha:1)
            gradient.colors = [UIColor(red:0.0/255, green:210.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:58.0/255, green:123.0/255, blue:213.0/255, alpha:1).cgColor]
            
        }
        else if(opStep?.percentageComplete == "0%"){
           // cell.backgroundColor = UIColor(red:255.0/255, green:195.0/255, blue:113.0/255, alpha:1)
            gradient.colors = [UIColor(red:240.0/255, green:240.0/255, blue:240.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]

        }
        else{
            
           // cell.backgroundColor = UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1)
                       gradient.colors = [UIColor(red:255.0/255, green:209.0/255, blue:148.0/255, alpha:1).cgColor, UIColor(red:112.0/255, green:225.0/255, blue:245.0/255, alpha:1).cgColor]
           
        }
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y :0)
         gradient.name = "gradient"
        let sublayer = cell.layer.sublayers?[0]
            
            if sublayer?.name == "gradient"{
                cell.layer.replaceSublayer(sublayer!, with: gradient)
            }
            
         cell.layer.insertSublayer(gradient, at: 0)
        
        cell.stepName.text = opStep?.name
        cell.stepName.lineBreakMode = .byWordWrapping
        cell.stepName.numberOfLines = 0
        return cell
            
        }
        
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: restoreOpReuseId, for: indexPath as IndexPath) as! OperationCollectionViewCell
            let restoreOp = self.detailItem!.restoreOperations[indexPath.item]
            
            cell.name.text = restoreOp.name
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
            cell.startTime.text = dateFormatter.string(from: restoreOp.startTime)
            
            if restoreOp.startTime == self.detailItem?.latestRestoreOperation?.startTime{
                //override lastcellSelected
                lastCellSelected = cell
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = cell.bounds
            gradient.colors = [UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1).cgColor, UIColor(red:142.0/255, green:158.0/255, blue:171.0/255, alpha:1).cgColor]
            gradient.startPoint = CGPoint.zero
            gradient.endPoint = CGPoint(x: 1,y :0)
            
            cell.layer.insertSublayer(gradient, at: 0)
            }
            return cell
            
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)  {
        
        switch item.tag  {
        case 0:
            self.logsView.isHidden = true
            
        case 1:
            self.logsView.isHidden = false
            break
       
        default:
            self.logsView.isHidden = true
            break
        }
        
        
    }
    
}

