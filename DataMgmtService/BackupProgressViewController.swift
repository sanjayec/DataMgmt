//
//  BackupProgressViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/26/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class BackupProgressViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var backupProgressCollection: UICollectionView!
    
    
    
    let reuseIdentifier = "Cell"
    var detailItem: Database?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backupProgressCollection.dataSource = self
        backupProgressCollection.delegate = self
                 backupProgressCollection.backgroundColor = UIColor.white
        
        if let backupProgressStr = self.detailItem?.runningBackupOperation?.percentageComplete {
            let endIndex = backupProgressStr.index((backupProgressStr.startIndex), offsetBy: ((backupProgressStr.characters.count)-1))
            
            
            let fractionalProgress = Float(backupProgressStr.substring(to: endIndex))! / 100.0
            progressView.setProgress(fractionalProgress, animated: true)
            progressLabel.text = backupProgressStr
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count =  (self.detailItem?.runningBackupOperation?.operationSteps.count){
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RestoreProgressCollectionViewCell
        let opStep = self.detailItem!.runningBackupOperation?.operationSteps[indexPath.item]
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        
        
        if (opStep?.percentageComplete == "100%"){
            // cell.backgroundColor = UIColor(red:22.0/255, green:191.0/255, blue:253.0/255, alpha:1)
            gradient.colors = [UIColor(red:0.0/255, green:210.0/255, blue:255.0/255, alpha:1).cgColor, UIColor(red:58.0/255, green:123.0/255, blue:213.0/255, alpha:1).cgColor]
            
        }
        else if(opStep?.percentageComplete == "0%"){
            //cell.backgroundColor = UIColor(red:255.0/255, green:195.0/255, blue:113.0/255, alpha:1)
            gradient.colors = [UIColor(red:240.0/255, green:240.0/255, blue:240.0/255, alpha:1).cgColor, UIColor(red:171.0/255, green:186.0/255, blue:171.0/255, alpha:1).cgColor]
            
        }
        else{
            
            // cell.backgroundColor = UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1)
            gradient.colors = [UIColor(red:255.0/255, green:209.0/255, blue:148.0/255, alpha:1).cgColor, UIColor(red:112.0/255, green:225.0/255, blue:245.0/255, alpha:1).cgColor]
            
        }
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1,y :0)
        
        cell.layer.insertSublayer(gradient, at: 0)
        
        cell.stepName.text = opStep?.name
        cell.stepName.lineBreakMode = .byWordWrapping
        cell.stepName.numberOfLines = 0
        return cell
    }

    @IBAction func gotoOpDetails(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showOpDetails", sender: self)
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOpDetails" {
            
                let operation = self.detailItem?.runningBackupOperation
            
            
            let viewController = (segue.destination as! UINavigationController).topViewController as! OpearationStepsViewController
            
            viewController.operation = operation
            
            let newBackButton = UIBarButtonItem(title: "Backups", style: .plain, target: self, action: #selector(viewController.goBackToParent))
            
            viewController.navigationItem.leftBarButtonItem = newBackButton // This will show in the next view controller being pushed
            
            //viewController.navigationItem.leftBarButtonItem = self. displayModeButtonItem
            viewController.navigationItem.leftItemsSupplementBackButton = true
            viewController.navigationItem.title = operation?.name

            
            }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//    @IBAction func goBack(_ sender: Any)
//    {
//        self.navigationController?.popViewController(animated: true)
//    }
}
