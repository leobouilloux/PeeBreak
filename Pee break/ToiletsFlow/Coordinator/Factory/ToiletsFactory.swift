//
//  ToiletsFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class ToiletsFactory: ToiletsFactoryInterface {
    func makeToiletsPresentable(with viewModel: ToiletsViewModelInterface) -> Presentable {
        return ToiletsController(with: viewModel)
    }
}
