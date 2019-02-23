//
//  ToiletsFactoryInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

protocol ToiletsFactoryInterface {
    func makeToiletsPresentable(with viewModel: ToiletsViewModelInterface) -> Presentable
}
