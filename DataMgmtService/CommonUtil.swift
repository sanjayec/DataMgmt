//
//  CommonUtil.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/30/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//
import UIKit

class CommonUtil {
    
    // GlobalVariables.NAFTIX, GlobalVariables.NUTANIX, GlobalVariables.ORATIX
    static let logoToBeUsed = GlobalVariables.NUTANIX
    
    static var viewController: UIViewController?
    static var navigationItem: UINavigationItem?
    static var homebarbuttonItem: UIBarButtonItem?
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
    
    // Rotate <targetView> indefinitely
    static func rotateView(targetView: UIButton, duration: Double = 1.0) {
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI/10))
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    // Rotate <targetView> indefinitely
    static func rotateView(targetView: UIImageView, duration: Double = 1.0) {
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI/10))
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    
    static func setNavigationBarItems(navigationItem: UINavigationItem, navController: UINavigationController, viewController: UIViewController){
        self.viewController = viewController
        self.navigationItem = navigationItem
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: logoToBeUsed), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(CommonUtil.brandButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        //set frame
        var width = 90
        var height = 18
        if(logoToBeUsed == GlobalVariables.NAFTIX){
            width = 90
            height = 18
        }
        else if(logoToBeUsed == GlobalVariables.NAFTIX){
            width = 130
            height = 20
        }
        else{
            width=90
            height = 18
        }
        button.frame = CGRect(x:0, y:0, width:width, height:height)
        
        
        let naftixButton = UIBarButtonItem(customView: button)
        
        
        //create a new button
        let button2: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button2.setImage(UIImage(named: "home_list"), for: UIControlState.normal)
        //add function for button
        button2.addTarget(self, action: #selector(CommonUtil.showProfilePopup), for: UIControlEvents.touchUpInside)
        //set frame
        button2.frame = CGRect(x:0, y:0, width:20, height:20)
        let homeButton = UIBarButtonItem(customView: button2)
        self.homebarbuttonItem = homeButton
        
        let isMaster: Bool = (self.viewController?.isKind(of: MasterViewController.self))!
        
        if !isMaster {
           navigationItem.setRightBarButtonItems([ homeButton, naftixButton], animated: true)
        }
        
        //assign button to navigationbar
      // navigationItem.rightBarButtonItem = naftixButton
        
        //set back button color
        navController.navigationBar.tintColor = UIColor.white
        
        navController.navigationBar.barTintColor = UIColor(red: 66.0/255, green: 75.0/255, blue:91.0/255, alpha:1)
        
         navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UITabBar.appearance().tintColor = UIColor(red: 66.0/255, green: 75.0/255, blue:91.0/255, alpha:1)

        UILabel.appearance().substituteFontNameLight = GlobalVariables.ProximaNovaLight
        UILabel.appearance().substituteFontName = GlobalVariables.ProximaNovaRegular
        UILabel.appearance().substituteFontNameBold = GlobalVariables.ProximaNovaBold
        UILabel.appearance().substituteFontNameSemibold = GlobalVariables.ProximaNovaSemiBold

    }
    @objc static func brandButtonClicked(sender: AnyObject){
        
    }
    
    @objc static func showProfilePopup(sender: AnyObject){
        let popover = viewController?.storyboard?.instantiateViewController(withIdentifier: "ProfilePopup") as! ProfileViewController
        popover.modalPresentationStyle = UIModalPresentationStyle.popover
        popover.popoverPresentationController?.backgroundColor = UIColor(red: 66.0/255, green: 75.0/255, blue:91.0/255, alpha:1)
        
        //popover.popoverPresentationController?.delegate = viewController as! UIPopoverPresentationControllerDelegate?
        
        popover.popoverPresentationController?.sourceView = (sender as! UIView)
      //  let originView = sender.value(forKey: "view")
       // var homeView = navigationItem?.rightBarButtonItems?[1].value(forKey: "view") as? UIView
        popover.popoverPresentationController?.sourceRect =  sender.bounds
        popover.popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
        popover.preferredContentSize = CGSize(width: 120, height: 100)
      //  popover.popoverPresentationController?.presentPopoverFromBarButtonItem(homebarbuttonItem, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
       // popover.popoverPresentationController?.barButtonItem = navigationItem?.rightBarButtonItems?[0]
       // popover.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up;

        
        viewController?.present(popover, animated: true, completion: nil)
    }
    
    
    static func getDuration(date1:Date, date2: Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = Calendar.current.dateComponents(dayHourMinuteSecond, from: date1, to: date2)
        
        let seconds = "\(difference.second!)s"
        let minutes = "\(difference.minute!)m" + " " + seconds
        let hours = "\(difference.hour!)h" + " " + minutes
        let days = "\(difference.day!)d" + " " + hours
        
        if difference.day!    > 0 { return days }
        if difference.hour!   > 0 { return hours }
        if difference.minute! > 0 { return minutes }
        if difference.second! > 0 { return seconds }
        return "0s"
    }
    static func startRotating(duration: Double = 1, button: UIButton) {
        let kAnimationKey = "rotation"
        
        if button.layer.animation(forKey: kAnimationKey) == nil {
            let animExists = button.layer.animation(forKey: "transform.rotation") != nil
            if !animExists {
                let animate = CABasicAnimation(keyPath: "transform.rotation")
                animate.duration = duration
                animate.repeatCount = Float.infinity
                animate.fromValue = 0.0
                animate.toValue = Float(M_PI * 2.0)
                button.layer.add(animate, forKey: kAnimationKey)
            }
        }
    }
    static func stopRotating(button: UIButton) {
        let kAnimationKey = "rotation"
        button.layer.removeAllAnimations()
        button.layer.removeAnimation(forKey: "transform.rotation")
        button.layer.removeAnimation(forKey: kAnimationKey)
        
        
        if button.layer.animation(forKey: kAnimationKey) != nil {
            button.layer.removeAllAnimations()
            button.layer.removeAnimation(forKey: kAnimationKey)
        }
        
        button.setNeedsDisplay()
    }
    
    
}
