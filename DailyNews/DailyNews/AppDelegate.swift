//
//  AppDelegate.swift
//  DailyNews
//
//  Created by Şevval Alev on 10.05.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = navigationController
        navigationController.navigationBar.backgroundColor = .black
        navigationController.toolbar.barStyle = .black
        let appearance = UINavigationBar.appearance()
        appearance.titleTextAttributes = [.foregroundColor:UIColor.white,.font:UIFont(name: "Oranienbaum-Regular", size: 35)!]
        window.makeKeyAndVisible()
        
        self.window = window
        
        // MARK: TabBar
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barStyle = .black
        tabBarController.tabBar.backgroundColor = .black
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .gray
        
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        mainViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "text.justify"), tag: 1)
        mainViewController.navigationBar.backgroundColor = .black
        mainViewController.toolbar.barStyle = .black
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        searchViewController.navigationBar.backgroundColor = .black
        searchViewController.toolbar.barStyle = .black
        
        tabBarController.viewControllers = [mainViewController, searchViewController]
        
        window.rootViewController = tabBarController
        
        
        
        return true
        
    }
}
