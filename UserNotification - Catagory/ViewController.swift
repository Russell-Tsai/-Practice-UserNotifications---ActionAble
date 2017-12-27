//
//  ViewController.swift
//  UserNotification - Catagory
//
//  Created by 蔡松樺 on 26/12/2017.
//  Copyright © 2017 蔡松樺. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNotification()
    }
    
    func makeNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Notification Category 教學"
        content.body = "想學一點東西嗎?"
        
        //設置通知對應 category 列舉標籤
        content.categoryIdentifier = NotificationCategory.news.rawValue
        
        //設置觸發
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //設置 ID
        let requestIdentifier = "personal.Russell.Practice"
        
        //設置通知請求
        let request = UNNotificationRequest(
            identifier: requestIdentifier,
            content: content,
            trigger: trigger)
        
        //將通知加到發送中心
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil {
                print("Time interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }

}

