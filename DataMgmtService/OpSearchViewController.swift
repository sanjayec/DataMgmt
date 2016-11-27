//
//  OpSearchViewController.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/25/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class OpSearchViewController: UIViewController, UISearchBarDelegate  {

    @IBOutlet weak var opSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchTextField: UITextField? = opSearchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder))  {
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search operation logs and analyze")
        }
//        self.opSearchBar.layer.borderColor = UIColor.lightGray.cgColor
//        self.opSearchBar.layer.borderWidth = 1
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
