//
//  AppDelegate.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var applicationCoordinator: ApplicationCoordinator?
    lazy var provider = DefaultProvider()

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        applicationCoordinator = ApplicationCoordinator(window: window,
                                                        coordinatorFactory: CoordinatorFactory(),
                                                        provider: provider)
        window.makeKeyAndVisible()
        applicationCoordinator?.start()
        self.window = window
        return true
    }
}
