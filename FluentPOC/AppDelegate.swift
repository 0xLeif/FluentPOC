//
//  AppDelegate.swift
//  FluentPOC
//
//  Created by CRi on 2/27/20.
//  Copyright © 2020 ol. All rights reserved.
//

import UIKit
import FluentSQLite

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public static var db = DatabaseManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

struct DatabaseManager {
  let db: SQLiteDatabase
  let group: MultiThreadedEventLoopGroup
  let test: DatabaseIdentifier<SQLiteDatabase>
  var config: DatabasesConfig
  let container: BasicContainer
  let databases: Databases
  public let pool: DatabaseConnectionPool<ConfiguredDatabase<SQLiteDatabase>>

  init() {
    guard let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        fatalError("Could not file 'documentDirectory'")
    }
    
    self.db = try! SQLiteDatabase(storage: .file(path: "\(filePath)/default.sqlite"))
    self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    self.test = "test"
    self.config = DatabasesConfig()
    config.add(database: db, as: test)
    self.container = BasicContainer(config: .init(), environment: .testing, services: .init(), on: group)
    self.databases = try! config.resolve(on: container)
    self.pool = try! databases.requireDatabase(for: test).newConnectionPool(config: .init(maxConnections: 20), on: self.group)
  }
}
