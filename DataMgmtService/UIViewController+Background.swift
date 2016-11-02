//
//  UIViewController+Background.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/29/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

extension UIViewController {
    func colorMe() {
        let imageViewBackground = CommonUtil.colorMe(sview: view)
        view.addSubview(imageViewBackground)
        view.sendSubview(toBack: imageViewBackground)

    }
}
