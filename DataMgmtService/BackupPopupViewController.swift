//
//  BackupPopupViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/26/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class BackupPopupViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var createdOn: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var storageType: UILabel!
    @IBOutlet weak var storageLocation: UILabel!
    
    var selectBackup: Backup?
    @IBOutlet weak var id: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name?.text = self.selectBackup?.name
        self.id?.text = self.selectBackup?.id
        self.status?.text = self.selectBackup?.status
        self.storageType?.text = self.selectBackup?.storageType
        self.storageLocation?.text = self.selectBackup?.storageLocation
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        self.createdOn?.text = dateFormatter.string(from: (self.selectBackup?.dateCreated)!)
        // Do any additional setup after loading the view.
        
        self.storageLocation.lineBreakMode = .byWordWrapping
        self.storageLocation.numberOfLines = 0
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = view.bounds
//        gradient.colors = [UIColor(red:44.0/255, green:62.0/255, blue:80.0/255, alpha:0.8).cgColor, UIColor(red:189.0/255, green:195.0/255, blue:199.0/255, alpha:1.0).cgColor]
        gradient.colors = [UIColor(red:238.0/255, green:242.0/255, blue:243.0/255, alpha:1).cgColor, UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1.0 ,y :0)
        
        view.layer.insertSublayer(gradient, at: 0)
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

}
