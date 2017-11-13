//
//  AppDelegate.swift
//  Map Scriptures
//
//  Created by Tyler Mabey on 11/6/17.
//  Copyright © 2017 Tyler Mabey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    // MARK: - Properties
    
    var window: UIWindow?
    
    private struct Storyboard {
        static let DetailVC = "DetailVC"
    }

    // MARK: - Application lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let splitViewController = window!.rootViewController as? UISplitViewController {
            splitViewController.delegate = self
        }
        
        return true
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        if let navVC = primaryViewController as? UINavigationController {
            for controller in navVC.viewControllers {
                if controller.restorationIdentifier == Storyboard.DetailVC {
                    return controller
                }
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: Storyboard.DetailVC)
        
        return detailVC
    }

}

