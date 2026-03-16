//
//  SceneDelegate.swift
//  SwiftDemoApp
//
//  Created by Vedant Pant on 14/03/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        // Search Tab
        let searchVC = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)

        // WebView Tab
        let webVC = WebViewController()
        let webNav = UINavigationController(rootViewController: webVC)
        webNav.tabBarItem = UITabBarItem(title: "PokéAPI", image: UIImage(systemName: "globe"), tag: 1)

        // Tab Bar Controller
        let tabBar = UITabBarController()
        tabBar.viewControllers = [searchNav, webNav]
        tabBar.tabBar.tintColor = .systemRed

        // Login wraps everything
        let loginVC = ViewController()
        loginVC.mainTabBar = tabBar
        let loginNav = UINavigationController(rootViewController: loginVC)

        window?.rootViewController = loginNav
        window?.makeKeyAndVisible()
    }


}

