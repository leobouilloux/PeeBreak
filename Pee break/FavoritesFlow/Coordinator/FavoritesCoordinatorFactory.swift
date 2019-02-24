//
//  FavoritesCoordinatorFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import UIKit

extension CoordinatorFactory {
    func makeFavoritesCoordinator(
        with provider: Provider,
        navController: NavigationController? = nil,
        coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
        ) -> FavoritesCoordinator {
        let coordinator = FavoritesCoordinator(router: router(navController),
                                               factory: FavoritesFactory(),
                                               coordinatorFactory: coordinatorFactory,
                                               provider: provider)
        return coordinator
    }
}
