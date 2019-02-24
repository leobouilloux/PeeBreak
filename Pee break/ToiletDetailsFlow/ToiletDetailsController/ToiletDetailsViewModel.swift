//
//  ToiletDetailsViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

final class ToiletDetailsViewModel: ToiletDetailsViewModelInterface {
    let hoursImage = BehaviorRelay<UIImage>(value: Asset.time.image.withRenderingMode(.alwaysTemplate))
    let addressImage = BehaviorRelay<UIImage>(value: Asset.location.image.withRenderingMode(.alwaysTemplate))
    let hours: BehaviorRelay<String>
    let address: BehaviorRelay<String>
    let output: ToiletDetailsOutputInferface = ToiletDetailsOutput()

    var data: ToiletData

    init(with provider: Provider, data: ToiletData) {
        self.data = data
        self.hours = BehaviorRelay<String>(value: data.hours)
        self.address = BehaviorRelay<String>(value: data.address)
    }
}
