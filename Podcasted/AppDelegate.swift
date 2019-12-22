//
//  AppDelegate.swift
//  Podcasted
//
//  Created by Ali Moussa on 19/09/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        // Set app tint color for navigationBar ItemButton and TabBar tint colour
        let appTintUIColorFromUserDefaults = loadAppTintUIColorFromUserDefaults()
        UITabBar.appearance().tintColor = appTintUIColorFromUserDefaults
        UIBarButtonItem.appearance().tintColor = appTintUIColorFromUserDefaults
        
        return true
    }
    
    func loadAppTintUIColorFromUserDefaults() -> UIColor {
        let appTintColorUserDefaults = UserDefaults.standard
        
        let appTintUIColorFromUserDefaults = appTintColorUserDefaults.colorForKey(key: "settings_appearance_appTintColor")
        
        if appTintUIColorFromUserDefaults != nil {
            return appTintUIColorFromUserDefaults ?? UIColor.systemBlue
        } else {
            return UIColor.systemBlue
        }
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
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    // lazy var persistentContainer: NSPersistentCloudKitContainer = {
    lazy var persistentContainer: NSPersistentContainer = {
        
        // let container = NSPersistentCloudKitContainer(name: "DataModel")
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
  
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

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

