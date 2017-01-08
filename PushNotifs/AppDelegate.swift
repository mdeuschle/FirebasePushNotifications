//
//  AppDelegate.swift
//  PushNotifs
//
//  Created by Matt Deuschle on 1/7/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in

            if granted {
                application.registerForRemoteNotifications()
            } else {
                print("Notiications declined \(error?.localizedDescription)")
            }
        }

        FIRApp.configure()

        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification(notification:)), name: NSNotification.Name.firInstanceIDTokenRefresh, object: nil)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

        FIRMessaging.messaging().disconnect()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        connectToFirebaseMessagingManager()

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func tokenRefreshNotification(notification: NSNotification) {
        let refreshedToken = FIRInstanceID.instanceID().token()
        print("Instance ID Token \(refreshedToken)")
        connectToFirebaseMessagingManager()

    }

    func connectToFirebaseMessagingManager() {
        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect to FB Messaging Manager \(error.debugDescription)")
            } else {
                print("Connected to FB Messaging")
            }
        }
    }
    
    
}

