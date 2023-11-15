//
//  AppDelegate.swift
//  Neobis_iOS_Calculating
//
//  Created by iPak Tulane on 15/11/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: CalculatorViewController())
        window?.makeKeyAndVisible()
        return true
    }
}
