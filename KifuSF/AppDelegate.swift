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
        
        let dg = DispatchGroup()
        dg.enter()
        DispatchQueue.global().async {
            try! Auth.auth().signOut() // swiftlint:disable:this force_try
            
            Auth.auth().signIn(withEmail: "e@g.com", password: "password", completion: { (result, error) in
                if let error = error {
                    fatalError(error.localizedDescription)
                }
                
                guard let firUser = result?.user
                    else {
                        fatalError("no user from result but no error was found or, validation failed with register button")
                }
                
                UserService.show(forUID: firUser.uid, completion: { (user) in
                    guard let user = user else {
                        fatalError("no user found when signing in")
                    }
                    
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    dg.leave()
                })
            })
        }
        
        dg.wait()
        
        //TODO: log-in / sign-up logic
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = KFCTabBar()
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.kfPrimary]
        UINavigationBar.appearance().tintColor = .kfPrimary
        UINavigationBar.appearance().barTintColor = .kfWhite
        UINavigationBar.appearance().isTranslucent = false
        
        UITabBar.appearance().tintColor = .kfPrimary
        UITabBar.appearance().barTintColor = .kfWhite
        UITabBar.appearance().isTranslucent = false
        
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
