//
//  AppDelegate.swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 1/27/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import Siren
import UIKit
import Firebase
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window?.makeKeyAndVisible()
        //setupForceUpdate()
        updateSpecificRulesExample()
//        AuthProvider.shared.validateUserName(username: "ahmedahmed") { (error, response) in
//            if let error = error {
//                print(error)
//            } else if let response = response, let data = response.data {
//                print(data)
//            }
//        }
////
//        AuthProvider.shared.getUserProfileWithoutToken(userId: "344fa6f13f32b485d41056393992b3f3") { (error, response) in
//            if let error = error {
//                print(error)
//            } else if let response = response {
//                print(response.friends.first?.displayName ?? "")
//            }
//        }
        
        Fabric.with([Crashlytics.self])
        Fabric.sharedSDK().debug = true
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

private extension AppDelegate {
//    func setupForceUpdate() {
//        let siren = Siren.shared
//        let rules = Rules(promptFrequency: .immediately, forAlertType: .force)
//        siren.rulesManager = RulesManager(globalRules: rules)
//        siren.wail()
//    }

    /// Major, Minor, Patch, and Revision specific rules implementations.
    func updateSpecificRulesExample() {
        let siren = Siren.shared
        siren.rulesManager = RulesManager(majorUpdateRules: .critical,
                                          minorUpdateRules: .none,
                                          patchUpdateRules: .default,
                                          revisionUpdateRules: Rules(promptFrequency: .weekly, forAlertType: .option))
        siren.wail { (results, error) in
            if let results = results {
                print("AlertAction ", results.alertAction)
                print("Localization ", results.localization)
                print("LookupModel ", results.lookupModel)
                print("UpdateType ", results.updateType)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
