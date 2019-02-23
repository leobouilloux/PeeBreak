//
//  FavoritessCoordinator.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class FavoritesCoordinator: BaseCoordinator {
    let output: FavoritesCoordinatorOutputInterface

    private let factory: FavoritesFactoryInterface
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider

    init(router: Router, factory: FavoritesFactoryInterface, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.output = FavoritesCoordinatorOutput()
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override public func start(with option: DeepLinkOption? = nil) {
        setupRoot()
    }
}

private extension FavoritesCoordinator {
    func setupRoot() {
        let viewModel = FavoritesViewModel(with: provider)
        let favoritesPresentable = factory.makeFavoritesPresentable(with: viewModel)
        router.setRootModule(favoritesPresentable)
    }
}
