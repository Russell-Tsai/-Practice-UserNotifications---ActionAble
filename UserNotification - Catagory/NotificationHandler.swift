//
//  NotificationHandler.swift
//  UserNotification - Catagory
//
//  Created by 蔡松樺 on 26/12/2017.
//  Copyright © 2017 蔡松樺. All rights reserved.
//

import UIKit
import UserNotifications

//通知 Category 列舉
enum NotificationCategory: String {
    case news
}

//通知 Category 的 Action 列舉
enum NotificationCategoryAction: String {
    case like
    case cancel
    case comment
}

//通知響應對象
class NotificationHandler: NSObject, UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //根據 Catetory 列舉做判斷
        let categoryIdentifier = response.notification.request.content.categoryIdentifier
        if let category = NotificationCategory(rawValue: categoryIdentifier) {
            switch category {
            case .news:
                handleNews(response : response)
            }
        }
        completionHandler()
    }
    
    //助理新聞通知的交互工作
    func handleNews(response : UNNotificationResponse) {
        let message : String
        if let actionType = NotificationCategoryAction(rawValue: response.actionIdentifier){
            switch actionType {
            case .like:
                message = "點擊了喜歡按鈕"
            case .cancel:
                message = "點擊了取消按鈕"
            case .comment:
                message = "輸入\((response as! UNTextInputNotificationResponse).userText)"
            }
        }
        else {
            //直接點擊通知，或是刪除此分支
            message = ""
        }
        
        //彈出相關訊息
        if !message.isEmpty {
            showAlert(message: message)
        }
        
    }
    
    //在目前頁面跳出普通訊息框
    func showAlert(message : String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController{
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "確定", style: .cancel, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }

}
