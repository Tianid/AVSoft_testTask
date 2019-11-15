//
//  AppDelegate.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 13.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var tabBarController: UITabBarController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
                
        let vc = ListOfPersoneViewController()
        let editVC = EditViewController()
        let aboutVC = AboutViewController()
        
        vc.tabBarItem = setupTabBarImage(iconName: "listIcon.png", title: "Просмотр")
        editVC.tabBarItem = setupTabBarImage(iconName: "editIcon.png", title: "Редактировать")
        aboutVC.tabBarItem = setupTabBarImage(iconName: "aboutIcon.png", title: "О программе")
        
        tabBarController = UITabBarController()
        tabBarController.setViewControllers([editVC, vc, aboutVC], animated: true)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        // Override point for customization after application launch.
        return true
    }

    private func setupTabBarImage(iconName: String, title: String) -> UITabBarItem {
        var tabBarItem = UITabBarItem()
        let image = UIImage(named: iconName)
        tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return tabBarItem
    }
}

