//
//  AppDelegate.swift
//  Wave
//
//  Created by Eude Lesperance on 10/26/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import KCFloatingActionButton

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let nav = UINavigationController(rootViewController: HomeViewController.shared )
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window?.makeKeyAndVisible()
        
        FIRApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        window?.rootViewController = nav
        
        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 23, green: 42, blue: 58)
        
        // Remove navbar shadow
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        statusBarBackgroundView.backgroundColor = UIColor.rgb(red: 33, green: 45, blue: 67)
        
        
        window?.addSubview(statusBarBackgroundView)
        
        statusBarBackgroundView.leadingAnchor.constraint(equalTo: (window?.leadingAnchor)!).isActive = true
        statusBarBackgroundView.trailingAnchor.constraint(equalTo: (window?.trailingAnchor)!).isActive = true
        statusBarBackgroundView.topAnchor.constraint(equalTo: (window?.topAnchor)!).isActive = true
        statusBarBackgroundView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        let item = KCFloatingActionButtonItem()
//        item.title = "Create an Event"
//        item.handler = { item in
//            let createVC = CreateEventViewController()
//            self.nav.pushViewController(createVC, animated: true)
//        }
//        
//        KCFABManager.defaultInstance().getButton().addItem(item: item)
//        KCFABManager.defaultInstance().show()
//        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
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
        
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

