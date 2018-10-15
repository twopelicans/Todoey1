//
//  AppDelegate.swift
//  Todoey
//
//  Created by Roy Freeman on 10/10/2018.
//  Copyright © 2018 Roy Freeman. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
  //      print(Realm.Configuration.defaultConfiguration.fileURL) //path for realm browser
        
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new Realm, \(error)")
        }
        
        return true
    }
    
    
}
