//
//  OperationTableViewCell.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/22/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class OperationTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var matchedText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
