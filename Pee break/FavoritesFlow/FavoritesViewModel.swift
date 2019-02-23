//
//  FavoritesViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class FavoritesViewModel: FavoritesViewModelInterface {
    let provider: Provider

    init(with provider: Provider) {
        self.provider = provider
    }
}
