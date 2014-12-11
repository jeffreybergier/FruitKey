//
//  AppDelegate.swift
//  FruitKey
//
//  Created by Jeffrey Bergier on 10/29/14.
//  Copyright (c) 2014 Saturday Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let applicationName = NSLocalizedString("FruitKey: ", comment: "Title of the Application that appears in the navigation bar. should be followed by a : and a space")
    
    private var howToUseViewController: LoopingMoviePlayerController?
    private var howToInstallViewController: LoopingMoviePlayerController?
    private var aboutTableViewController: AboutTableViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //how to use video
        let howToUsePath = NSBundle.mainBundle().pathForResource("howToUseVideo", ofType: "mp4")
        if let howToUsePath = howToUsePath {
            let howToUseURL = NSURL(fileURLWithPath: howToUsePath)
            if let howToUseURL = howToUseURL {
                let titleString = NSLocalizedString("How to Use", comment: "How to use appears in the tab bar controller and is where the user finds out how to use the app")
                let tabBarImage = UIImage(named: "tabBar2")
                
                howToUseViewController = LoopingMoviePlayerController(contentURL: howToUseURL)
                howToUseViewController?.title = self.applicationName + titleString
                
                if let tabBarImage = tabBarImage {
                    tabBarImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                    howToUseViewController?.tabBarItem = UITabBarItem(title: titleString, image: tabBarImage, tag: 1)
                }
            }
        }
        
        //how to install view
        let howToInstallPath = NSBundle.mainBundle().pathForResource("howToInstallVideo", ofType: "mp4")
        if let howToInstallPath = howToInstallPath {
            let howToInstallURL = NSURL(fileURLWithPath: howToInstallPath)
            if let howToInstallURL = howToInstallURL {
                let titleString = NSLocalizedString("How to Install", comment: "How to install appears in the tab bar controller and is where the user finds out how to install the keyboard")
                let tabBarImage = UIImage(named: "tabBar1")
                
                howToInstallViewController = LoopingMoviePlayerController(contentURL: howToInstallURL)
                howToInstallViewController?.title = self.applicationName + titleString
                
                if let tabBarImage = tabBarImage {
                    tabBarImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                    howToInstallViewController?.tabBarItem = UITabBarItem(title: titleString, image: tabBarImage, tag: 0)
                }
            }
        }
        
        //about screen from storyboard
        let aboutStoryboard: UIStoryboard? = UIStoryboard(name: "AboutTableViewController", bundle: nil)
        if let aboutStoryboard = aboutStoryboard {
            self.aboutTableViewController = aboutStoryboard.instantiateInitialViewController() as? AboutTableViewController
            if let aboutTableViewController = self.aboutTableViewController {
                let titleString = NSLocalizedString("About", comment: "About appears in the tab bar controller and is where the user finds out about the company that made the app")//"About"
                let tabBarImage = UIImage(named: "tabBar3")
                
                aboutTableViewController.title = self.applicationName + titleString
                
                if let tabBarImage = tabBarImage {
                    tabBarImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                    aboutTableViewController.tabBarItem = UITabBarItem(title: titleString, image: tabBarImage, tag: 3)
                }
            }
        }
        
        // create an empty array that I can add View Controller objects into
        // this helps increase reliability because each view controller is optional
        // this allows me to unwrap the optionals 1 at a time instead of 3 at once. 
        // It increases reliability of the the root view controller loading even if something went wrong with one of the optionals.
        var tabBarControllerArray: [UINavigationController] = []
        
        //check all the optionals and add them into the array
        if let howToInstallViewController = self.howToInstallViewController {
            let howToInstallNavigationController = FKNavigationController(rootViewController: howToInstallViewController)
            tabBarControllerArray.append(howToInstallNavigationController)
        }
        
        if let howToUseViewController = self.howToUseViewController {
            let howToUseNavigationController = FKNavigationController(rootViewController: howToUseViewController)
            tabBarControllerArray.append(howToUseNavigationController)
        }
        
        if let aboutTableViewController = self.aboutTableViewController {
            let aboutTableViewNavigationController = FKNavigationController(rootViewController: aboutTableViewController)
            tabBarControllerArray.append(aboutTableViewNavigationController)
        }

        //set up the tab bar controller with the populated array
        let tabBarController = FKTabBarController()
        if tabBarControllerArray.count > 0 {
            tabBarController.viewControllers = tabBarControllerArray
        }
        
        //set up the rootview controller
        self.window?.rootViewController = tabBarController
        
        //set the window background color
        self.window?.backgroundColor = UIColor.whiteColor()
        
        //make the window visible
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

