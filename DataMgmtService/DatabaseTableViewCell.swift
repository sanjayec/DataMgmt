//
//  DatabaseTableViewCell.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/14/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class DatabaseTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var databaseName: UILabel!
    
    @IBOutlet weak var datasource: UILabel!
    
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var expiresIn: UILabel!
    @IBOutlet weak var Status: UIButton!
    @IBOutlet weak var statusBtnText: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
        

}
