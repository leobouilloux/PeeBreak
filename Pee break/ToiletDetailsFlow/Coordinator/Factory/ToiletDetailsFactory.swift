//
//  ToiletDetailsFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class ToiletDetailsFactory: ToiletDetailsFactoryInterface {
    func makeToiletDetailsPresentable(with viewModel: ToiletDetailsViewModelInterface) -> Presentable {
        return ToiletDetailsController(with: viewModel)
    }
}
