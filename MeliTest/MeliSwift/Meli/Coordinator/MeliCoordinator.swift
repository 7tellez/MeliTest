//
//  AppCordinator.swift
//  Meli
//
//  Created by Cristian Tellez on 2/12/21.
//  Copyright © 2021 Cristian Tellez. All rights reserved.
//

import UIKit


class MeliCoordinator : Coordinator {
    
    private let window : UIWindow
    private let rootView: UINavigationController
    private let homeCoordinator : HomeCoordinator?
    
    init(window: UIWindow) {
        let navigation = UINavigationController()
        navigation.navigationBar.isHidden = true
        
        self.window = window
        rootView = navigation
        
        homeCoordinator = HomeCoordinator(presenter: rootView)
    }
    
    func start() {
        window.rootViewController = rootView
        homeCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
