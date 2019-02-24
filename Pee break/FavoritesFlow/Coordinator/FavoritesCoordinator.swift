//
//  FavoritessCoordinator.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxSwift

final class FavoritesCoordinator: BaseCoordinator {
    let output: FavoritesCoordinatorOutputInterface

    private let factory: FavoritesFactoryInterface
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider
    private let bag = DisposeBag()

    init(router: Router, factory: FavoritesFactoryInterface, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.output = FavoritesCoordinatorOutput()
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)

        bindOutputs()
    }

    override func start(with option: DeepLinkOption? = nil) {
        setupRoot()
    }
}

private extension FavoritesCoordinator {
    func setupRoot() {
        let viewModel = FavoritesViewModel(with: provider)
        viewModel.output.toiletDetailsAction.bind(to: output.toiletDetailsAction).disposed(by: bag)
        let favoritesPresentable = factory.makeFavoritesPresentable(with: viewModel)
        router.setRootModule(favoritesPresentable)
    }

    // *****************************************************************************
    // - MARK: Outputs
    func bindOutputs() {
        bindToiletDetailsOutput()
    }

    func bindToiletDetailsOutput() {
        output.toiletDetailsAction
            .subscribe(onNext: { [weak self] toiletData in
                guard let self = self else { return }

                let coordinator = self.coordinatorFactory.makeToiletDetailsCoordinator(router: self.router, provider: self.provider)
                coordinator.output.finishFlowAction
                    .subscribe(onNext: { [weak self] in
                        self?.removeDependency(coordinator)
                        self?.router.popModule()
                    })
                    .disposed(by: self.bag)
                self.addDependency(coordinator)
                coordinator.start(with: toiletData)
            })
            .disposed(by: bag)
    }
}
