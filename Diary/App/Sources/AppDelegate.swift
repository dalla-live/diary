//
//  AppDelegate.swift
//  av
//
//  Created by cheonsong on 2022/09/05.
//

import UIKit
import RealmSwift
import Repository

class Sh {
    static let shared : Sh = .init()
}
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let GOOGLE_API_KEY = "AIzaSyCufAiUM6o1EKSLquAZtZGa8WVRgr2iEiY"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let config = Realm.Configuration(schemaVersion: 0,
//                                         migrationBlock: { migration, oldSchemaVersion in
//            if oldSchemaVersion < 0 {
//                migration.enumerateObjects(ofType: BookmarkEntity.className(), { old, new in
//
//                })
//            }
//        },
//        deleteRealmIfMigrationNeeded: true)
//
//        Realm.Configuration.defaultConfiguration = config
//
        return true
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


}

