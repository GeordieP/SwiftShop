//
//  AppDelegate.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import UIKit
import Combine
import GRDB

// Default app model instance
var App = AppModel(database: { fatalError("Database is uninitialized") })

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let dbPool = try! createDbPool(application)
    App = AppModel(database: { dbPool })
    
    return true
  }

  private func createDbPool(_ application: UIApplication) throws -> DatabasePool {
    let databaseURL = try FileManager.default
      .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      .appendingPathComponent("db2.sqlite")
    
    let dbPool = try AppDatabase.openDatabase(atPath: databaseURL.path)
    dbPool.setupMemoryManagement(in: application)

    return dbPool
  }

  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
