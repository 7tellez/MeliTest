//
//  AppDelegate.swift
//  Meli
//
//  Created by Cristian Tellez on 2/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var applicationCoordinator : MeliCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let meliCoordinator = MeliCoordinator(window: window)
        
        self.window = window
        self.applicationCoordinator = meliCoordinator
        
        self.applicationCoordinator?.start()
        
        return true
    }

}

