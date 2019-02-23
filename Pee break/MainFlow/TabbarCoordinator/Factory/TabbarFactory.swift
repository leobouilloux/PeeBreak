//
//  TabbarFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class TabbarFactory: TabbarFactoryInterface {
    func makeTabbarCoordinator(provider: Provider) -> TabbarCoordinator {
        let tabbarController = TabbarController()
        let coordinator = TabbarCoordinator(tabbarController: tabbarController,
                                            coordinatorFactory: CoordinatorFactory(),
                                            provider: provider)
        return coordinator
    }
}
