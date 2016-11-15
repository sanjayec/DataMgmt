//
//  DataChangeTableViewCell.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/10/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class DataChangeTableViewCell: UITableViewCell {

    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var tableName: UILabel!
    @IBOutlet weak var recordsInBackup1: UILabel!
     
    @IBOutlet weak var percentageDifference: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var recordsInBackup2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
