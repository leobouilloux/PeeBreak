//
//  CoordinatorFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import UIKit

public class CoordinatorFactory {
    public init() {}

    public func router(_ navController: NavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }

    public func navigationController(_ navController: NavigationController?) -> NavigationController {
        return navController ?? NavigationController(rootViewController: UIViewController())
    }
}
