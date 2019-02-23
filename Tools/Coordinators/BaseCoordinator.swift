//
//  BaseCoordinator.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

open class BaseCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    public let router: Router

    public init(router: Router) {
        self.router = router
    }

    open func start(with option: DeepLinkOption? = nil) {
        if let option = option {
            childCoordinators.forEach { coordinator in
                coordinator.start(with: option)
            }
        }
    }
}
