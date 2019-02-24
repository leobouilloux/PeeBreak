//
//  ToiletDetailsViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import MapKit
import RxCocoa
import RxSwift

final class ToiletDetailsViewModel: ToiletDetailsViewModelInterface {
    let hoursImage = BehaviorRelay<UIImage>(value: Asset.time.image.withRenderingMode(.alwaysTemplate))
    let addressImage = BehaviorRelay<UIImage>(value: Asset.location.image.withRenderingMode(.alwaysTemplate))
    let hours: BehaviorRelay<String>
    let address: BehaviorRelay<String>
    let output: ToiletDetailsOutputInferface = ToiletDetailsOutput()

    var data: ToiletData
    var annotations: Driver<[MKPointAnnotation]> {
        return privateAnnotations.asDriver(onErrorJustReturn: [])
    }

    private let provider: Provider
    private let privateAnnotations = BehaviorRelay<[MKPointAnnotation]>(value: [])
    private let bag = DisposeBag()

    init(with provider: Provider, data: ToiletData) {
        self.provider = provider
        self.data = data
        self.hours = BehaviorRelay<String>(value: data.hours)
        self.address = BehaviorRelay<String>(value: data.address)

        setupAnnotations()
        setupRxBindings()
    }
}

private extension ToiletDetailsViewModel {
    // *****************************************************************************
    // - MARK: Setup
    private func setupAnnotations() {
        let annotation = MKPointAnnotation()
        if let distance = data.distance.value {
            if Int(distance) / 1000 == 0 {
                annotation.title = "\(data.distance)m"
                annotation.title = String(format: "%.0fm", distance)
            } else {
                annotation.title = String(format: "%.1fkm", distance / 1000)
            }
        }
        annotation.subtitle = data.hours
        annotation.coordinate = CLLocationCoordinate2D(latitude: data.x, longitude: data.y)

        self.privateAnnotations.accept([annotation])
    }

    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings() {
        bindAddFavoriteOutput()
    }

    func bindAddFavoriteOutput() {
        output.addFavoriteAction
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }

                if self.data.isFavorite {
                    self.provider.dataProvider.removeFavorite(data: self.data)
                } else {
                    self.provider.dataProvider.addFavorite(data: self.data)
                }
            })
            .disposed(by: bag)
    }
}
