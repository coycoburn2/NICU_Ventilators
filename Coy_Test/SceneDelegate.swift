//
//  SceneDelegate.swift
//  Coy_Test
//
//  Created by Coy Coburn on 10/1/22.
//

import UIKit

let NOTIF_INTERVAL = 129600
let BODY_OFFSET = 14

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    /*let timer2 = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("notification_title", comment: "")
        content.body = NSLocalizedString("notification_body", comment: "")
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }*/

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        //timer.invalidate()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        var randomInt = 0
        let content = UNMutableNotificationContent()
        var identifier = [""]
        
        //Wipe away the user notifications from last background transition
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        for x in 0..<7
        {
            let tmp = randomInt
            
            //Don't need any repeats
            while(tmp == randomInt)
            {
                randomInt = Int.random(in: 0..<(appNotificationsString.allCases.endIndex / 2))
            }

            identifier.append(String(randomInt))
            //UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier.last!])
            
            content.title = appNotificationsString.allCases[randomInt].localized
            content.body = appNotificationsString.allCases[randomInt + BODY_OFFSET].localized
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(NOTIF_INTERVAL) * Double(x + 1), repeats: false)
            let request = UNNotificationRequest(identifier: identifier.last!, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }


}

