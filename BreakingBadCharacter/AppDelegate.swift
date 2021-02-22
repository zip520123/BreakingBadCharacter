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
    var appFlow: AppFlow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        appFlow = AppFlow(service: ApiService(), charactersViewModel: CharactersViewModel())
        window?.rootViewController = appFlow?.navigationController
        window?.makeKeyAndVisible()
        
        appFlow?.start()
        return true
    }

    
}

