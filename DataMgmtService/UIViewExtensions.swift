//
//  UIViewExtensions.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/25/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
//        if let delegate: AnyObject = completionDelegate {
//            rotateAnimation.delegate = delegate
//        }
//        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}