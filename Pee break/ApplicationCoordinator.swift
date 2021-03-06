//
//  ApplicationCoordinator.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxSwift

final class ApplicationCoordinator: Coordinator {
    var window: UIWindow
    var childCoordinators = [Coordinator]()
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider

    private let bag = DisposeBag()

    init(window: UIWindow, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.coordinatorFactory = coordinatorFactory
        self.window = window
        self.provider = provider
    }

    func start(with option: DeepLinkOption? = nil) {
        if let option = option, !childCoordinators.isEmpty {
            switch option {
            default: childCoordinators.forEach { $0.start(with: option) }
            }
        } else {
            runSplashScreenFlow()
        }
    }

    private func runSplashScreenFlow(with option: DeepLinkOption? = nil) {
        let coordinator = coordinatorFactory.makeSplashScreenCoordinator(with: provider)
        coordinator.output.finishFlowAction
            .subscribe(onNext: { [weak self, weak coordinator] _ in
                self?.removeDependency(coordinator)
                self?.runMainFlow()
            })
            .disposed(by: bag)
        addDependency(coordinator)
        coordinator.start(with: option)

        window.rootViewController = coordinator.router.toPresent()
    }

    private func runMainFlow(with option: DeepLinkOption? = nil) {
        let coordinator = TabbarFactory().makeTabbarCoordinator(provider: provider)
        addDependency(coordinator)
        coordinator.start(with: option)

        window.rootViewController = coordinator.tabbarRouter.toPresent()
    }
}
