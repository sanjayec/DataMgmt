//
//  CommonUtil.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/30/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//
import UIKit

class CommonUtil {
    static func getThemeView( sview: UIView?, type: String?) -> UIImageView {
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mysql_theme")!)
        
        
        
        let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width-100, height: UIScreen.main.bounds.height-100))
        if(type == "mysql_database"){
        imageViewBackground.image = UIImage(named: "mysql_theme")
        }
        else {
            imageViewBackground.image = UIImage(named: "oracle_theme")
           // imageViewBackground.alpha = 0.5
        }
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        return imageViewBackground
              
    }
    static func colorMe( sview: UIView?, type: String?) {
        
        
        
              if(type == "mysql_database"){
                sview?.backgroundColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1)

        }
        else {
                sview?.backgroundColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1)

            // imageViewBackground.alpha = 0.5
        }
        
       
        
    }
}
