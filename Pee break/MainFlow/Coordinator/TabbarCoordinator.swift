//
//  TabbarCoordinator.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class TabbarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

//    let output: TabbarCoordinatorOutputInterface = TabbarCoordinatorOutput()
    let tabbarRouter: TabbarController

    let coordinatorFactory: CoordinatorFactory
    let provider: Provider
    let bag = DisposeBag()

    init(tabbarController: TabbarController, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.tabbarRouter = tabbarController
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        self.setupChildCoordinators()
    }

    func start(with option: DeepLinkOption? = nil) {
        if let option = option {
            switch option {
            default: break
            }
        }
        childCoordinators.forEach { $0.start(with: option) }
    }

    func setupChildCoordinators(with option: DeepLinkOption? = nil) {
        let toiletsCoordinator = createToiletsFlow()
        let favoritesCoordinator = createFavoritesFlow()

        childCoordinators = [
            toiletsCoordinator,
            favoritesCoordinator
        ]

        tabbarRouter.viewControllers = [
            toiletsCoordinator.router.toPresent() as? NavigationController ?? UIViewController(),
            favoritesCoordinator.router.toPresent() as? NavigationController ?? UIViewController()
        ]
    }

    func createToiletsFlow() -> ToiletsCoordinator {
        let toiletsCoordinator = coordinatorFactory.makeToiletsCoordinator(with: provider)
        toiletsCoordinator.start()
        addDependency(toiletsCoordinator)
        return toiletsCoordinator
    }

    func createFavoritesFlow() -> FavoritesCoordinator {
        let favoritesCoordinator = coordinatorFactory.makeFavoritesCoordinator(with: provider)
        favoritesCoordinator.start()
        addDependency(favoritesCoordinator)
        return favoritesCoordinator
    }
}

// *****************************************************************************************************************
// MARK: - Helpers
extension TabbarCoordinator {
    var currentRouter: Router? {
        switch tabbarRouter.selectedIndex {
        case 0: return messageRouter
        case 1: return favoriteRouter
        default: return nil
        }
    }

    var messageRouter: Router? {
        return (childCoordinators[0] as? ToiletsCoordinator)?.router
    }

    var favoriteRouter: Router? {
        return (childCoordinators[1] as? FavoritesCoordinator)?.router
    }
}
