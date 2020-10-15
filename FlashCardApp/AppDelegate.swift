//
//  AppDelegate.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/5/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        creatMainTabBarWindow()
        FirebaseApp.configure()
        Twitter.configure()
        return true
    }
    
    func creatMainTabBarWindow() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainTabBarController = storyboard.instantiateViewController(
            withIdentifier: "MainTabBarController") as? MainTabBarController {
            window?.rootViewController = mainTabBarController
            window?.makeKeyAndVisible()
        }
    }
    
    private func requestPermissionPushNoti() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in
        }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

    func application( _ app: UIApplication,
                      open url: URL,
                      options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        
        if TWTRTwitter.sharedInstance().application(app, open:url, options: options) {
            return true
        }
        if url.scheme != nil && url.scheme!.hasPrefix("fb") && url.host ==  "authorize" {
            let OURL = UIApplication.OpenURLOptionsKey.sourceApplication
            ApplicationDelegate.shared.application( app,
                                                    open: url,
                                                    sourceApplication:options[OURL] as? String,
                                                    annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
            return true
        }
        return false
    }
}

