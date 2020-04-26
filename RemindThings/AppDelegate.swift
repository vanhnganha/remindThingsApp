//
//  AppDelegate.swift
//  RemindThings
//
//  Created by NganHa on 4/18/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var navigationController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // start default firestore
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)
        if #available(iOS 13, *) {

         } else {
             let isCheck = UserDefaults.standard.bool(forKey: "isAuth")
            if isCheck == true {
                navigate(K.ScreenName.TabBarController)
            }
            else {
                navigate(K.ScreenName.startScreen)
            }
         }
        return true
    }
    
    func navigate(_ identifierName: String) {
        let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifierName)
        let navigationController = UINavigationController(rootViewController: rootVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

