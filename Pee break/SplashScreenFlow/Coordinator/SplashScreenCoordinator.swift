//
//  SplashScreenCoordinator.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxSwift

final class SplashScreenCoordinator: BaseCoordinator {
    private let factory: SplashScreenFactoryInterface
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider
    private let bag = DisposeBag()

    let output: SplashScreenCoordinatorOutput

    init(router: Router, factory: SplashScreenFactoryInterface, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.output = SplashScreenCoordinatorOutput()
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override func start(with option: DeepLinkOption? = nil) {
        setupRoot()
    }
}

private extension SplashScreenCoordinator {
    func setupRoot() {
        let viewModel = SplashScreenViewModel(with: provider)
        viewModel.output.finishFlowAction.bind(to: output.finishFlowAction).disposed(by: bag)
        let splashScreenPresentable = factory.makeSplashScreenPresentable(with: viewModel)
        router.setRootModule(splashScreenPresentable)
    }
}
