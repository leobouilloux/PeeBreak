//
//  SplashScreenViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa
import RxSwift

final class SplashScreenViewModel: SplashScreenViewModelInterface {
    let backgroundImage = BehaviorRelay<UIImage>(value: Asset.splashscreen.image)
    let isLoading = PublishRelay<Bool>()
    let output: SplashScreenOutputInterface = SplashScreenOutput()

    private let provider: Provider
    private let bag = DisposeBag()

    init(with provider: Provider) {
        self.provider = provider
    }

    func fetchData() {
        isLoading.accept(true)
        provider.dataProvider.updateData()
            .subscribe { [weak self] in
                self?.isLoading.accept(false)
                self?.output.finishFlowAction.accept(())
            }
            .disposed(by: bag)
    }
}
