//
//  MaskingTableViewCell.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/23/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class MaskingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
   
    @IBOutlet weak var dateCreated: UILabel!
    
    @IBOutlet weak var maskedColumns: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
