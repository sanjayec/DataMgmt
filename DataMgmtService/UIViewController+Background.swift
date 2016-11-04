//
//  UIViewController+Background.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/29/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

extension UIViewController {
    func addThemeMe(type: String?) {
        let imageViewBackground = CommonUtil.getThemeView(sview: view, type: type)
        view.addSubview(imageViewBackground)
        view.sendSubview(toBack: imageViewBackground)

    }
    func colorMe(type: String?) {
        CommonUtil.colorMe(sview: view, type: type)
        
//        UINavigationBar.appearance().backgroundColor = UIColor(red:76.0/255, green:162.0/255, blue:205.0/255, alpha:1)
//
//        UIBarButtonItem.appearance().tintColor = UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1)
//
//        //Since iOS 7.0 UITextAttributeTextColor was replaced by NSForegroundColorAttributeName
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:255.0/255, green:255.0/255, blue:255.0/255, alpha:1)
//]
      //  UITabBar.appearance().backgroundColor = UIColor.yellow
        
//        var nav = self.navigationController?.navigationBar
//        nav?.barStyle = UIBarStyle.blackTranslucent
//        nav?.tintColor = UIColor.white
//        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.gre]

    }
}
