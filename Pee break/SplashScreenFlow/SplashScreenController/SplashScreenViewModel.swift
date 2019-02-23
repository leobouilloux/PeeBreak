//
//  SplashScreenViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

final class SplashScreenViewModel: SplashScreenViewModelInterface {
    let backgroundImage = BehaviorRelay<UIImage>(value: Asset.splashscreen.image)
    let isLoading = PublishRelay<Bool>()
    let output: SplashScreenOutputInterface = SplashScreenOutput()

    private let provider: Provider

    init(with provider: Provider) {
        self.provider = provider
    }
}

private extension SplashScreenViewModel {
    func fetchData() {
        provider.dataProvider.updateData()
    }
}
