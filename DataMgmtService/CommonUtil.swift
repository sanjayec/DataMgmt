//
//  CommonUtil.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/30/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//
import UIKit

class CommonUtil {
    static func colorMe( sview: UIView?) -> UIImageView {
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mysql_theme")!)
        
        
        
        let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width-100, height: UIScreen.main.bounds.height-100))
        imageViewBackground.image = UIImage(named: "mysql_theme")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        return imageViewBackground
              
    }
}
