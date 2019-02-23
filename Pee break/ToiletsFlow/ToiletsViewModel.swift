//
//  ToiletsViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class ToiletsViewModel: ToiletsViewModelInterface {
    let provider: Provider

    init(with provider: Provider) {
        self.provider = provider
    }
}
