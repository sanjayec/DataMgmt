//
//  BackupCollectionViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/21/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit


class BackupCollectionViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate{
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
//    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
    var isRotating = false
    var shouldStopRotating = false
    var timer: Timer!
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = (self.detailItem?.backups.count) {
             return count
        }
        return 0
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    // get a reference to our storyboard cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! BackupCollectionViewCell
    
    // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let backup = self.detailItem!.backups[indexPath.item]
       cell.backupName.text = backup.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        cell.createdOn.text = "Created on: "+dateFormatter.string(from: self.detailItem!.backups[indexPath.item].dateCreated)
        cell.storageType.text = "Storage Type: "+self.detailItem!.backups[indexPath.item].storageType
        if backup.status == "Running" {
            let gradient: CAGradientLayer = CAGradientLayer()
            
            gradient.frame = view.bounds
             gradient.colors = [UIColor(red:255.0/255, green:209.0/255, blue:148.0/255, alpha:1).cgColor, UIColor(red:112.0/255, green:225.0/255, blue:245.0/255, alpha:1).cgColor]
                       gradient.startPoint = CGPoint.zero
            gradient.endPoint = CGPoint(x: 0.4,y :0)
            
            cell.layer.insertSublayer(gradient, at: 0)
            
            cell.backupIcon.image = #imageLiteral(resourceName: "gear")
             
            //rotate image infinitely
            
            UIView.animate(withDuration: 1, delay: 0.0, options: .curveLinear, animations: {
                cell.backupIcon.transform =  cell.backupIcon.transform.rotated(by: CGFloat(M_PI/10))
            }) { finished in
                self.rotateView(targetView: cell.backupIcon, duration: 1)
            }
            
        }
        else{
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1).cgColor, UIColor(red:142.0/255, green:158.0/255, blue:171.0/255, alpha:1).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0.4,y :0)
        
        cell.layer.insertSublayer(gradient, at: 0)
        }

   // cell.backgroundColor = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
        
        cell.layer.cornerRadius = 10

    
    return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // handle tap events
        if let indexPath = self.collectionView?.indexPathsForSelectedItems{
            let selectedCellSourceView = collectionView.cellForItem(at: indexPath[0])
            let selectedCellSourceRect = selectedCellSourceView?.bounds
            let backup =  self.detailItem?.backups[indexPath[0].row]

            if(backup?.status == "Running"){
                let popover = self.storyboard?.instantiateViewController(withIdentifier: "backupProgressPopup") as! BackupProgressViewController
                popover.modalPresentationStyle = UIModalPresentationStyle.popover
                popover.popoverPresentationController?.backgroundColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1.0)
                
                popover.popoverPresentationController?.delegate = self
                popover.popoverPresentationController?.sourceView = selectedCellSourceView
                popover.popoverPresentationController?.sourceRect = selectedCellSourceRect!
                popover.popoverPresentationController?.permittedArrowDirections = .any
                popover.preferredContentSize = CGSize(width: 1200, height: 160)
                
                //map database object
                popover.detailItem = self.detailItem
                
                self.present(popover, animated: true, completion: nil)
            }
            else{
            let popover = self.storyboard?.instantiateViewController(withIdentifier: "backupPopup") as! BackupPopupViewController
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
                popover.popoverPresentationController?.backgroundColor = UIColor(red:240.0/255, green:240.0/255, blue:240.0/255, alpha:1.0)
            
            popover.popoverPresentationController?.delegate = self
            popover.popoverPresentationController?.sourceView = selectedCellSourceView
            popover.popoverPresentationController?.sourceRect = selectedCellSourceRect!
            popover.popoverPresentationController?.permittedArrowDirections = .any
            popover.preferredContentSize = CGSize(width: 500, height: 250)
            
            //get data
            popover.selectBackup = backup
          
            
            self.present(popover, animated: true, completion: nil)
            }
            
        }
          }
    // change background color when user touches cell
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
       // cell?.backgroundColor = UIColor(red:75.0/255, green:121.0/255, blue:161.0/255, alpha:1)
    }
    
    // change background color back when user releases touch
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        //cell?.backgroundColor = UIColor(red:224.0/255, green:234.0/255, blue:252.0/255, alpha:1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(BackupCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
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
//            if (nameLabel) != nil{
//                nameLabel.text = detail.name
//            }
            navigationItem.title = self.detailItem?.name
        }
    }
    
      func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.shouldStopRotating == false {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(M_PI * 2)
            rotateAnimation.duration = 1
           // cell.backupIcon.layer.add(rotateAnimation, forKey: nil)
        } else {
            self.reset()
        }
    }
    
    func reset() {
        self.isRotating = false
        self.shouldStopRotating = false
    }
    
    // Rotate <targetView> indefinitely
    private func rotateView(targetView: UIImageView, duration: Double = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI/10))
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }

}
