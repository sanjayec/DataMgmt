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
    
    static func setNavigationBarItems(navigationItem: UINavigationItem, navController: UINavigationController){
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "naftix_icon"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: Selector(("nil")), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x:0, y:0, width:90, height:18)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
       navigationItem.rightBarButtonItem = barButton
        
        //set back button color
        navController.navigationBar.tintColor = UIColor.white
        
        navController.navigationBar.barTintColor = UIColor(red: 66.0/255, green: 75.0/255, blue:91.0/255, alpha:1)
        
         navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UITabBar.appearance().tintColor = UIColor(red: 66.0/255, green: 75.0/255, blue:91.0/255, alpha:1)

        
    }
}
