//
//  SchemaChangeTableViewCell.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/10/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class SchemaChangeTableViewCell: UITableViewCell {
    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var objectType: UILabel!
    @IBOutlet weak var change: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
