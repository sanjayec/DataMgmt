//
//  UICollectionViewController+Background.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/30/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//
import UIKit

extension UICollectionViewController {
    override func colorMe(type: String?) {
        //super.colorMe()
        let imageViewBackground = CommonUtil.getThemeView(sview: view, type: type)
        self.collectionView?.backgroundView = imageViewBackground
    }
}
