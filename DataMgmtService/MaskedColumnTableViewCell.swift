//
//  MaskedColumnTableViewCell.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/23/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class MaskedColumnTableViewCell: UITableViewCell {

    @IBOutlet weak var tableName: UILabel!
    @IBOutlet weak var columnName: UILabel!
    @IBOutlet weak var columnType: UILabel!
    @IBOutlet weak var format: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
