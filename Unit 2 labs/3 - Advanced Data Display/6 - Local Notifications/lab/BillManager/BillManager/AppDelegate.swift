//
//  AppDelegate.swift
//  BillManager
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            // Set UNUserNotificationCenter delegate
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            
            // Define actions
            let remindInAnHourAction = UNNotificationAction(
                identifier: "REMIND_IN_AN_HOUR",
                title: "Remind Me in an Hour",
                options: []
            )
            
            let markAsPaidAction = UNNotificationAction(
                identifier: "MARK_AS_PAID",
                title: "Mark as Paid",
                options: [.authenticationRequired]
            )
            
            // Define the category with both actions
            let billCategory = UNNotificationCategory(
                identifier: Bill.notificationCategoryID,
                actions: [remindInAnHourAction, markAsPaidAction],
                intentIdentifiers: [],
                options: []
            )
            
            // Register the category
            center.setNotificationCategories([billCategory])
            
            return true
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

