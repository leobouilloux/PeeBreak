//
//  FavoritesFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class FavoritesFactory: FavoritesFactoryInterface {
    func makeFavoritesPresentable(with viewModel: FavoritesViewModelInterface) -> Presentable {
        return FavoritesController(with: viewModel)
    }
}
