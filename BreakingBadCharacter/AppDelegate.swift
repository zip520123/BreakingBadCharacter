//
//  AppDelegate.swift
//  BreakingBadCharacter
//
//  Created by zip520123 on 21/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .gray
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }


}

