//
//  SplashScreenFactory.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class SplashScreenFactory: SplashScreenFactoryInterface {
    func makeSplashScreenPresentable(with viewModel: SplashScreenViewModelInterface) -> Presentable {
        return SplashScreenController(with: viewModel)
    }
}
