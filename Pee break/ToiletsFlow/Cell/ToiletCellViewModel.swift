//
//  ToiletCellViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa
import RxSwift

final class ToiletCellViewModel: ToiletCellViewModelInterface {
    let address: BehaviorRelay<String>
    let hours: BehaviorRelay<String>
    let lattitude: BehaviorRelay<Double>
    let longitude: BehaviorRelay<Double>
    let favoriteImage = BehaviorRelay<UIImage>(value: UIImage())

    private let isFavorite: BehaviorRelay<Bool>
    private let bag = DisposeBag()

    init(with data: ToiletData) {
        self.address = BehaviorRelay<String>(value: data.address)
        self.hours = BehaviorRelay<String>(value: data.hours)
        self.longitude = BehaviorRelay<Double>(value: data.x)
        self.lattitude = BehaviorRelay<Double>(value: data.y)
        self.isFavorite = BehaviorRelay<Bool>(value: data.isFavorite)

        setupRxBindings()
    }

    func setupRxBindings() {
        bindIsFavorite()
    }

    func bindIsFavorite() {
        isFavorite
            .subscribe(onNext: { [weak self] isFavorite in
                let image = isFavorite ? Asset.favourite.image : UIImage()
                self?.favoriteImage.accept(image)
            })
            .disposed(by: bag)
    }
}
