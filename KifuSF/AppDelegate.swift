//
//  AppDelegate.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = KFCTabBar()
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.kfPrimary]
        UINavigationBar.appearance().tintColor = .kfPrimary
        UINavigationBar.appearance().barTintColor = .kfWhite
        UINavigationBar.appearance().isTranslucent = false

        UITabBar.appearance().tintColor = .kfPrimary
        UITabBar.appearance().barTintColor = .kfWhite
        UITabBar.appearance().isTranslucent = false
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()!.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        if Auth.auth().currentUser != nil,
            let userData = UserDefaults.standard.object(forKey: "currentUser") as? Data,
            let user = try? JSONDecoder().decode(User.self, from: userData) {
            
            User.setCurrent(user)
        }

        return true
    }

    //TODO: alex-login logic
    private func setInitalViewController() {
        if Auth.auth().currentUser != nil,
            let userData = UserDefaults.standard.object(forKey: "currentUser") as? Data,
            let user = try? JSONDecoder().decode(User.self, from: userData) {

            User.setCurrent(user)

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialVC = storyboard.instantiateViewController(withIdentifier: "initialTabBar")

            window?.rootViewController = initialVC
            window?.makeKeyAndVisible()
        } else {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let initialVC = storyboard.instantiateViewController(withIdentifier: "kfLogin")
            window?.rootViewController = initialVC
            window?.makeKeyAndVisible()
        }
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication: options[.sourceApplication] as? String,
            annotation: [:])

    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            return assertionFailure(error.localizedDescription)
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        let credentialDict = ["credentials": credential] as [String: Any]
        NotificationCenter.default.post(name: .userDidLoginWithGoogle, object: nil, userInfo: credentialDict)
    }

    //TODO: Handle disconnect logic
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {

    }
}
