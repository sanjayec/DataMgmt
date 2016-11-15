//
//  MaskingViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/13/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class MaskingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Masking/Subsetting"
        CommonUtil.setNavigationBarItems(navigationItem: self.navigationItem,navController: self.navigationController!,viewController: self)

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

}
