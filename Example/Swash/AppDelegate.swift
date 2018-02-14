//
//  AppDelegate.swift
//  Swash
//
//  Created by Sam Francis on 01/26/2018.
//  Copyright (c) 2018 Mindgrub. All rights reserved.
//

import UIKit
import Swash

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Swash.logFontBoilerplate(filter: "gill")
        return true
    }
    
}
