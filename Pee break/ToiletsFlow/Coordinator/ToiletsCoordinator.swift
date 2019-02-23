//
//  ToiletsCoordinator.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

public final class ToiletsCoordinator: BaseCoordinator {
    private let factory: ToiletsFactoryInterface
    public let output: ToiletsCoordinatorOutputInterface
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider

    init(router: Router, factory: ToiletsFactoryInterface, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.output = ToiletsCoordinatorOutput()
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override public func start(with option: DeepLinkOption? = nil) {
        setupRoot()
    }
}

private extension ToiletsCoordinator {
    func setupRoot() {
        let viewModel = ToiletsViewModel(with: provider)
        let toiletsPresentable = factory.makeToiletsPresentable(with: viewModel)
        router.setRootModule(toiletsPresentable)
    }
}
