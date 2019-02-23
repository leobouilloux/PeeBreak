//
//  TabbarFactoryInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

protocol TabbarFactoryInterface {
    func makeTabbarCoordinator(provider: Provider) -> TabbarCoordinator
}
