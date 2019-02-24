//
//  SplashScreenCoordinatorFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import UIKit

extension CoordinatorFactory {
    func makeSplashScreenCoordinator(
        with provider: Provider,
        navController: NavigationController? = nil,
        coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
        ) -> SplashScreenCoordinator {
        let coordinator = SplashScreenCoordinator(router: router(navController),
                                               factory: SplashScreenFactory(),
                                               coordinatorFactory: coordinatorFactory,
                                               provider: provider)
        return coordinator
    }
}
