//
//  CloneActionsViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/25/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class CloneActionsViewController: UIViewController {

    @IBOutlet weak var fullClone: UIButton!
    @IBOutlet weak var snapClone: UIButton!
    @IBOutlet weak var snapswitch: UISwitch!
    
    @IBOutlet weak var snapSwitchText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonStyle(button: fullClone)
        addButtonStyle(button: snapClone)
        
        snapswitch.transform = CGAffineTransform(scaleX: 0.50, y: 0.50);
snapSwitchText.numberOfLines = 0
        snapSwitchText.lineBreakMode = .byWordWrapping
    }
    
    func addButtonStyle(button: UIButton){
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = self.view.tintColor.cgColor
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
