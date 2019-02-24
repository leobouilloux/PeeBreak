//
//  ToiletDetailsCoordinatorFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

extension CoordinatorFactory {
    func makeToiletDetailsCoordinator(router: Router, provider: Provider) -> ToiletDetailsCoordinator {
        let coordinator = ToiletDetailsCoordinator(
            router: router,
            factory: ToiletDetailsFactory(),
            provider: provider
        )
        return coordinator
    }
}
