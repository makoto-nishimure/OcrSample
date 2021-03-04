//
//  AppDelegate.swift
//  StackViewSample
//
//  Created by makoto on 2021/02/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let memosDao: MemosDao = MemosDao.sharedInstance
        memosDao.deleteAll()
        
        let TODO = ["境界線上のホライゾン", "Heart of Lapis", "芥見下々"]
        let CTX = ["Horizon on the Middle of Nowhere", "ラピスの心臓", "呪術廻戦"]
        
        for i in 0 ..< TODO.count {
            _ = memosDao.create(title: TODO[i], contents: CTX[i])
        }
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

