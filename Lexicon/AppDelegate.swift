//
//  AppDelegate.swift
//  Lexicon
//
//  Created by admin on 26.02.2020.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Create a window that is the same size as the screen
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let StartVC = StartViewController()
        window?.rootViewController = UINavigationController(rootViewController: StartVC)
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle


}

