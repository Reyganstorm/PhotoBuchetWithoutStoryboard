//
//  AppDelegate.swift
//  PhotoBuchetWithoutStoryboard
//
//  Created by Руслан Штыбаев on 06.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = TabBarViewController()
        return true
    }
}



