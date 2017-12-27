//
//  AppDelegate.swift
//  UserNotification - Catagory
//
//  Created by 蔡松樺 on 26/12/2017.
//  Copyright © 2017 蔡松樺. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationHandler = NotificationHandler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //請求通知權限
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (accepted, error) in
            if !accepted {
                print("用戶不接受通知")
            }
        }
        //註冊 Category
        registerNotificationCategory()
        UNUserNotificationCenter.current().delegate = notificationHandler
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //註冊 Category
    private func registerNotificationCategory(){
        let newsCategory: UNNotificationCategory = {
            //創建輸入本文的 action
            let inputAction = UNTextInputNotificationAction(
                identifier: NotificationCategoryAction.comment.rawValue,
                title: "評論",
                options: [.foreground],
                textInputButtonTitle: "發送",
                textInputPlaceholder: "留下評論...")
            
            //創見按鈕 action
            let likeAction = UNNotificationAction(
                identifier: NotificationCategoryAction.like.rawValue,
                title: "點讚",
                options: [.foreground])
            
            let cancelAction = UNNotificationAction(
                identifier: NotificationCategoryAction.cancel.rawValue,
                title: "取消",
                options: [.destructive])
            
            //創建 category
            return UNNotificationCategory(identifier: NotificationCategory.news.rawValue, actions: [inputAction, likeAction, cancelAction], intentIdentifiers: [], options: [.customDismissAction])
        }()
        //把 category 加到通知中心
        UNUserNotificationCenter.current().setNotificationCategories([newsCategory])
    }

}

