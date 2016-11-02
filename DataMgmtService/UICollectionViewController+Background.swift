//
//  UICollectionViewController+Background.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/30/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//
import UIKit

extension UICollectionViewController {
    override func colorMe() {
        //super.colorMe()
        let imageViewBackground = CommonUtil.colorMe(sview: view)
        self.collectionView?.backgroundView = imageViewBackground
    }
}
