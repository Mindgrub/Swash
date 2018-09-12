//
//  AppDelegate.swift
//  Swash
//
//  Created by Sam Francis on 01/26/2018.
//  Copyright © 2018 Mindgrub. All rights reserved.
//

import UIKit
import Swash

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Log boilerplate for only the GillSans font family
        Swash.logBoilerplate(forFontsWithFamilyNamesContaining: "gill")
        return true
    }
    
}
