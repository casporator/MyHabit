//
//  SceneDelegate.swift
//  MyHabits2
//
//  Created by Oleg Popov on 21.09.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        
        var habbitsTabBarNavigatorController = UINavigationController()
        var infoTabBarNavigatorController = UINavigationController()
        
        habbitsTabBarNavigatorController = UINavigationController.init(rootViewController: HabbitsViewController())
        infoTabBarNavigatorController = UINavigationController.init(rootViewController: InfoViewController())

        tabBarController.viewControllers = [habbitsTabBarNavigatorController, infoTabBarNavigatorController]
        
        let item1 = UITabBarItem(title: "Привычки", image: UIImage(named: "Shape"), tag: 0)
        let item2 = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)

        habbitsTabBarNavigatorController.tabBarItem = item1
        infoTabBarNavigatorController.tabBarItem = item2
        
        UITabBar.appearance().tintColor = purpleColor
        UITabBar.appearance().backgroundColor = .systemGray
        

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
     
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

