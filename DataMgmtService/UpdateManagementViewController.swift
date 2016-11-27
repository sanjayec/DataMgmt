//
//  UpdateManagementViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/26/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class UpdateManagementViewController: UIViewController {

    var detailItem: Database? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ( self.navigationController != nil ) {
            CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if self.detailItem != nil {
           //resultsArray = (self.detailItem?.operations)!
        }
        
        navigationItem.title = self.detailItem?.name
    }


}
