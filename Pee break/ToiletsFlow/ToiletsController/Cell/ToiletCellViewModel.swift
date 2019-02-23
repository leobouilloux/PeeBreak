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
    let distance = BehaviorRelay<String>(value: "NaN")
    let favoriteImage = BehaviorRelay<UIImage>(value: UIImage())

    private let isFavorite: BehaviorRelay<Bool>
    private let bag = DisposeBag()

    init(with data: ToiletData) {
        self.address = BehaviorRelay<String>(value: data.address)

        let formattedHours = " \(data.hours.replacingOccurrences(of: " ", with: "")) "
        self.hours = BehaviorRelay<String>(value: formattedHours)

        self.isFavorite = BehaviorRelay<Bool>(value: data.isFavorite)

        if let distance = data.distance.value {
            if Int(distance) / 1000 == 0 {
                self.distance.accept(String(format: "%.0fm", distance))
            } else {
                self.distance.accept(String(format: "%.1fkm", distance / 1000))
            }
        }

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
