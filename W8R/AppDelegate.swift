//
//  AppDelegate.swift
//  W8R
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 04/03/2017.
//  Copyright © 2017 joamafer. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import SquareRegisterSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupFirebase()
        setupPushNotifications(application: application)
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if let paymentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: PaymentViewController.self)) as? PaymentViewController {
            paymentViewController.price = Int(response.notification.request.content.body)
            paymentViewController.modalTransitionStyle = .crossDissolve
            if let rootVC = self.window?.rootViewController {
                rootVC.present(paymentViewController, animated: true, completion: nil)
            }
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication]
        if (sourceApplication as! String).hasPrefix("com.squareup.square") {
            let response = try! SCCAPIResponse(responseURL: url)
            print(response)
            
            return true
        }
        
        return false
    }
    
    // MARK: Setup
    
    func setupFirebase() {
        FIRApp.configure()
    }
    
    func setupPushNotifications(application: UIApplication) {
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            UNUserNotificationCenter.current().delegate = self
            FIRMessaging.messaging().remoteMessageDelegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
}

extension AppDelegate: FIRMessagingDelegate {
    
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
    }
    
}

