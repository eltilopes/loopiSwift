//
//  AppDelegate.swift
//  Loopi
//
//  Created by Loopi on 11/12/17.
//  Copyright © 2017 Loopi. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let customURLScheme = "dlscheme"
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //GMSServices.provideAPIKey("AIzaSyCXuNEWDOjSXCoQbDyl8dd-Xobe-4vwaGM")
        //GMSPlacesClient.provideAPIKey("AIzaSyCXuNEWDOjSXCoQbDyl8dd-Xobe-4vwaGM")
        GMSServices.provideAPIKey("AIzaSyBcU9bk64c7cOig4us1WMlO_o_k7Ococ6o")
        GMSPlacesClient.provideAPIKey("AIzaSyBcU9bk64c7cOig4us1WMlO_o_k7Ococ6o")
        
        
        // FirebaseApp.configure()
        // Set deepLinkURLScheme to the custom URL scheme you defined in your
        // Xcode project.
        FirebaseOptions.defaultOptions()?.deepLinkURLScheme = self.customURLScheme
        FirebaseApp.configure()
        
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
      
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            }
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            
            NotificationsController.shared.registerForUserFacingNotificationsFor(application)
        }
        
        application.registerForRemoteNotifications()

        
 
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = true
        // Just for logging to the console when we establish/tear down our socket connection.
        listenForDirectChannelStateChanges();
        NotificationsController.configure()
        // [END set_messaging_delegate]
        // BackgroundLocationManager.instance.start()
        let token = Messaging.messaging().fcmToken
        print("***** MY FCM token: \(token ?? "")")
        NotificationCenter.default.addObserver(self, selector: "tokenRefreshNotification:", name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)

        

        return true
    }
    
    
    // [START openurl]
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return application(app, open: url,
                           sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                           annotation: "")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            // Handle the deep link. For example, show the deep-linked content or
            // apply a promotional offer to the user's account.
            // [START_EXCLUDE]
            // In this sample, we just open an alert.
            handleDynamicLink(dynamicLink)
            // [END_EXCLUDE]
            return true
        }
        // [START_EXCLUDE silent]
        // Show the deep link that the app was called with.
        showDeepLinkAlertView(withMessage: "openURL:\n\(url)")
        // [END_EXCLUDE]
        return false
    }
    // [END openurl]
    // [START continueuseractivity]
    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
            // [START_EXCLUDE]
            // [END_EXCLUDE]
        }
        
        // [START_EXCLUDE silent]
        if !handled {
            // Show the deep link URL from userActivity.
            let message = "continueUserActivity webPageURL:\n\(userActivity.webpageURL?.absoluteString ?? "")"
            showDeepLinkAlertView(withMessage: message)
        }
        // [END_EXCLUDE]
        return handled
    }
    // [END continueuseractivity]
    func handleDynamicLink(_ dynamicLink: DynamicLink) {
        let matchConfidence: String
        if dynamicLink.matchType == .weak {
            matchConfidence = "Weak"
        } else {
            matchConfidence = "Strong"
        }
        let message = "App URL: \(dynamicLink.url?.absoluteString ?? "")\n" +
        "Match Confidence: \(matchConfidence)\nMinimum App Version: \(dynamicLink.minimumAppVersion ?? "")"
        showDeepLinkAlertView(withMessage: message)
    }
    
    func showDeepLinkAlertView(withMessage message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: "Deep-link Data", message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    func application(_ application: UIApplication,
                     didRegister notificationSettings: UIUserNotificationSettings) {
        NotificationCenter.default.post(name: UserNotificationsChangedNotification, object: nil)
    }
    
    // Handle refresh notification token
    func tokenRefreshNotification(notification: NSNotification) {
        let refreshedToken = InstanceID.instanceID().token()
        print("InstanceID token: \(refreshedToken)")
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        if (refreshedToken != nil)
        {
            connectToFcm()
            
            Messaging.messaging().subscribe(toTopic: "/topics/topic")
        }
        
    }
    
    // Connect to FCM
    func connectToFcm() {
        Messaging.messaging().connect { (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
        // InstanceID.instanceID().setAPNSToken(deviceToken, type: InstanceIDAPNSTokenType.unknown)
        NotificationCenter.default.post(name: APNSTokenReceivedNotification, object: nil)
        if #available(iOS 8.0, *) {
        } else {
            // On iOS 7, receiving a device token also means our user notifications were granted, so fire
            // the notification to update our user notifications UI
            NotificationCenter.default.post(name: UserNotificationsChangedNotification, object: nil)
        }
        // Forward the token to your provider, using a custom method.
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        NotificationCenter.default.addObserver(self, selector: "tokenRefreshNotification:", name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Messaging.messaging().shouldEstablishDirectChannel = true
        print("Disconnected from FCM.")
        NotificationCenter.default.addObserver(self, selector: "tokenRefreshNotification:", name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        print("Loopi")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        application.applicationIconBadgeNumber = 0;
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Loopi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        Messaging.messaging().shouldEstablishDirectChannel = true
        connectToFcm()
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {

        guard let data =
            try? JSONSerialization.data(withJSONObject: remoteMessage.appData, options: .prettyPrinted),
            let jsonString = String(data: data, encoding: .utf8) else {
                return
        }
        let firebaseMessage = FirebaseMessage.deserialize(from: jsonString)!
        print("--------------")
        print("--------------")
        print("FirebaseMessage:\n\(firebaseMessage.titulo)")
        
        let viewController = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "AceitarServico") as! UIViewController
        self.window?.rootViewController = viewController
    }
    // [END ios_10_data_message]
    
   
}

extension AppDelegate {
    func listenForDirectChannelStateChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(onMessagingDirectChannelStateChanged(_:)), name: .MessagingConnectionStateChanged, object: nil)
    }
    
    @objc func onMessagingDirectChannelStateChanged(_ notification: Notification) {
        print("FCM Direct Channel Established: \(Messaging.messaging().isDirectChannelEstablished)")
    }
}

extension Dictionary {
    /// Utility method for printing Dictionaries as pretty-printed JSON.
    var jsonString: String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
            let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        return nil
    }
}
