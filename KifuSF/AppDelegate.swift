//
//  AppDelegate.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVC = storyboard.instantiateViewController(withIdentifier: "initialTabBar")
        
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.kfPrimary]
        UINavigationBar.appearance().tintColor = UIColor.kfPrimary
        UITabBar.appearance().tintColor = UIColor.kfPrimary
        
        return true
    }
    
    private func setInitalViewController() {
        if Auth.auth().currentUser != nil,
            let userData = UserDefaults.standard.object(forKey: "currentUser") as? Data,
            let user = try? JSONDecoder().decode(User.self, from: userData) {
            
            User.setCurrent(user)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialVC = storyboard.instantiateViewController(withIdentifier: "initialTabBar")
            
            window?.rootViewController = initialVC
            window?.makeKeyAndVisible()
        }
    }
}
