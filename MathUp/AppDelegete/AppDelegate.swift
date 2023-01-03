//
//  AppDelegate.swift
//  ZhenShen
//
//  Created by abb on 11.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBar = TabBarViewController()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        return true
    }
}
