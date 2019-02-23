//
//  ToiletsCoordinatorFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import UIKit

extension CoordinatorFactory {
    func makeToiletsCoordinator(
        with provider: Provider,
        navController: UINavigationController? = nil,
        coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
        ) -> ToiletsCoordinator {
        let coordinator = ToiletsCoordinator(router: router(navController),
                                               factory: ToiletsFactory(),
                                               coordinatorFactory: coordinatorFactory,
                                               provider: provider)
        return coordinator
    }
}
