//
//  DatasourceBackupCollectionViewCell.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 11/1/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

class DatasourceBackupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var createdOn: UILabel!
    @IBOutlet weak var storageType: UILabel!
//    @IBOutlet weak var assocOrRefresh: UIButton!
    @IBOutlet weak var assocOrRefresh: UIButton!
    
    @IBOutlet weak var image: UIImageView!
}
