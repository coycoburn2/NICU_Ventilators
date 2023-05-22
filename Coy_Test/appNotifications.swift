//
//  appNotifications.swift
//  NICU Ventilators
//
//  Created by Coy Coburn on 5/12/23.
//

import Foundation
import UIKit
import UserNotifications
import BackgroundTasks
import BackgroundAssets

class appNotifications : OperationQueue{
    
    var random = 0
    
    func setReminder(){
        //BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.apple-samplecode.ColorFeed.refresh", using: nil) { task in
        //     self.handleAppRefresh(task: task as! BGProcessingTask)
        //}
        //var timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        //RunLoop.main.add(timer, forMode: .common)
        // Schedule a daily notification
        //let content1 = UNMutableNotificationContent()
        //content1.title = appNotificationsString.allCases[random].localized
        //content1.body = appNotificationsString.allCases[random + BODY_OFFSET].localized
        //let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        //let request1 = UNNotificationRequest(identifier: "daily-reminder", content: content1, trigger: trigger1)
        //UNUserNotificationCenter.current().add(request1)
        
        // Schedule a weekly notification
        //let content2 = UNMutableNotificationContent()
        //content2.title = "Reminder Style 2"
        //content2.body = "Open my app and stay up to date."
        //var dateComponents = DateComponents()
        //dateComponents.weekday = 7
        //dateComponents.hour = 9
        //dateComponents.minute = 0
        //let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //let request2 = UNNotificationRequest(identifier: "weekly-reminder", content: content2, trigger: trigger2)
        //UNUserNotificationCenter.current().add(request2)
    }
    
    class startTimer : Operation{
        //var timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
        override func main(){
            var randomInt = Int.random(in: 0..<(appNotificationsString.allCases.endIndex / 2))
            let content = UNMutableNotificationContent()
            let identifier = ["daily-reminder"]
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier[0]])
            
            content.title = appNotificationsString.allCases[randomInt].localized
            content.body = appNotificationsString.allCases[randomInt + BODY_OFFSET].localized
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
            let request = UNNotificationRequest(identifier: "daily-reminder", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
        //}
    }
    /*
    func handleAppRefresh(task: BGProcessingTask) {
       // Schedule a new refresh task.
       scheduleAppRefresh()
        
        var randomInt = Int.random(in: 0..<(appNotificationsString.allCases.endIndex / 2))
        let content = UNMutableNotificationContent()
        let identifier = ["daily-reminder"]
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier[0]])
        
        content.title = appNotificationsString.allCases[randomInt].localized
        content.body = appNotificationsString.allCases[randomInt + BODY_OFFSET].localized
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        let request = UNNotificationRequest(identifier: "daily-reminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)

/*
       // Create an operation that performs the main part of the background task.
       let operation = startTimer()
       
       // Provide the background task with an expiration handler that cancels the operation.
       task.expirationHandler = {
          operation.cancel()
       }


       // Inform the system that the background task is complete
       // when the operation completes.
       operation.completionBlock = {
          task.setTaskCompleted(success: !operation.isCancelled)
       }


       // Start the operation.
        self.addOperation(operation)
 */
        
        task.setTaskCompleted(success: true)
     }
    
    func scheduleAppRefresh() {
       let request = BGProcessingTaskRequest(identifier: "com.example.apple-samplecode.ColorFeed.refresh")
       // Fetch no earlier than 15 minutes from now.
       request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60)
            
       do {
          try BGTaskScheduler.shared.submit(request)
       } catch {
          print("Could not schedule app refresh: \(error)")
       }
    }
    
    
    
    @objc func loop(){
        random = Int.random(in: 0..<(appNotificationsString.allCases.endIndex / 2))
        print(random)
        
        let identifier = ["daily-reminder"]
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier[0]])
        
        // Schedule a daily notification
        let content1 = UNMutableNotificationContent()
        content1.title = appNotificationsString.allCases[random].localized
        content1.body = appNotificationsString.allCases[random + BODY_OFFSET].localized
        let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: true)
        let request1 = UNNotificationRequest(identifier: identifier[0], content: content1, trigger: trigger1)
        UNUserNotificationCenter.current().add(request1)
    }
     */
}
