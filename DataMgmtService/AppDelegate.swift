//
//  AppDelegate.swift
//  DataMgmtService
//
//  Created by Sanjay Ediga on 10/14/16.
//  Copyright © 2016 nftx.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if (self.window!.rootViewController as? LoginViewController) != nil{
            let controllerId = "Login"
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: controllerId) as UIViewController
            self.window?.rootViewController = initViewController
            
            return true
        }
        else{
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        splitViewController.preferredPrimaryColumnWidthFraction = 0.5;
        splitViewController.maximumPrimaryColumnWidth = splitViewController.view.bounds.size.width;

        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
       // navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        let tabBarController = navigationController.topViewController! as? UITabBarController
        let summaryController = (tabBarController?.viewControllers?[0] as! UINavigationController).topViewController as!  DbSummaryViewController
        summaryController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        
        let dataMgmtController = (tabBarController?.viewControllers?[1] as! UINavigationController).topViewController as! DataMgmtViewController
        dataMgmtController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
//        let backupsController = (tabBarController?.viewControllers?[2] as! UINavigationController).topViewController as! BackupCollectionViewController
//        backupsController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
//        
        
        splitViewController.delegate = self
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let tabBarController = secondaryAsNavController.topViewController as? UITabBarController else { return false }
        let summaryController = (tabBarController.viewControllers?[0] as! UINavigationController).topViewController as!  DbSummaryViewController
        
        let dataMgmtController = (tabBarController.viewControllers?[1] as! UINavigationController).topViewController  as! DataMgmtViewController
        
        if summaryController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        if dataMgmtController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // I added this line
        UITabBar.appearance().tintColor = UIColor(red: 66.0/255, green: 75.0/255, blue:91.0/255, alpha:1)
        
        return true
    }

}

