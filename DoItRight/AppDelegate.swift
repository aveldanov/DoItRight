//
//  AppDelegate.swift
//  DoItRight
//
//  Created by Veldanov, Anton on 3/25/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    print(Realm.Configuration.defaultConfiguration.fileURL)
    
    
    // Just to catch any errors with Realm
    do{
       _ = try Realm()
     }catch{
       print("realm error: \(error)")
     }
    
    

    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//    print(#function)

  }
  
  



  
  


}

