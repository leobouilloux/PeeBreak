//
//  FavoritesViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

//
//  ToiletsViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import CoreLocation
import MapKit
import RxCocoa
import RxSwift

final class FavoritesViewModel: FavoritesViewModelInterface {
    let provider: Provider

    let title = BehaviorRelay<String>(value: "Toilettes favorites")

    var annotations: Driver<[MKPointAnnotation]> {
        return privateAnnotations.asDriver(onErrorJustReturn: [])
    }
    let isLoading = PublishRelay<Bool>()
    let output: FavoritesOutputInterface = FavoritesOutput()

    let userLocation = BehaviorRelay<CLLocation?>(value: nil)

    private let data = BehaviorRelay<[ToiletData]>(value: [])
    let dataSource = BehaviorRelay<[ToiletsCellType]>(value: [])
    private let privateAnnotations = BehaviorRelay<[MKPointAnnotation]>(value: [])

    private let bag = DisposeBag()

    init(with provider: Provider) {
        self.provider = provider

        getData()
        setupRxBindings()
    }
}

private extension FavoritesViewModel {
    // *****************************************************************************
    // - MARK: Provider
    func getData() {
        provider.dataProvider.getFavorites().bind(to: data).disposed(by: bag)
    }

    func fetchToiletsData() {
        isLoading.accept(true)
        provider.dataProvider.updateData()
            .subscribe({ [weak self] _ in
                self?.isLoading.accept(false)
            })
            .disposed(by: bag)
    }

    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings() {
        bindData()
        bindUserLocation()
        bindUpdateDataOutput()
    }

    func bindData() {
        data
            // swiftlint:disable:next closure_body_length
            .subscribe(onNext: { [weak self] toiletsData in
                let sortedToiletData = toiletsData.sorted(by: { data1, data2 -> Bool in
                    guard
                        let distance1 = data1.distance.value,
                        let distance2 = data2.distance.value
                        else { return false }
                    return distance1 < distance2
                })
                let cells = sortedToiletData.map { ToiletsCellType.toilet(value: $0) }
                let annotations = sortedToiletData.map { toilet -> MKPointAnnotation in
                    let location = CLLocation(latitude: toilet.x, longitude: toilet.y)
                    let annotation = MKPointAnnotation()
                    if let distance = toilet.distance.value {
                        if Int(distance) / 1000 == 0 {
                            annotation.title = "\(distance)m"
                            annotation.title = String(format: "%.0fm", distance)
                        } else {
                            annotation.title = String(format: "%.1fkm", distance / 1000)
                        }
                    }
                    annotation.subtitle = toilet.hours
                    annotation.coordinate = location.coordinate
                    return annotation
                }
                self?.dataSource.accept(cells)
                self?.privateAnnotations.accept(annotations)
            })
            .disposed(by: bag)
    }

    func bindUserLocation() {
        userLocation
            .skip(1)
            .throttle(5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] userLocation in
                guard
                    let userLocation = userLocation,
                    let data = self?.data
                    else { return }
                let newData = data.value.map { toiletData -> ToiletData in
                    let location = CLLocation(latitude: toiletData.x, longitude: toiletData.y)
                    toiletData.distance.value = Float(location.distance(from: userLocation))
                    return toiletData
                }
                data.accept(newData)
            })
            .disposed(by: bag)
    }

    func bindUpdateDataOutput() {
        output.updateDataAction
            .subscribe(onNext: { [weak self] in
                self?.fetchToiletsData()
            })
            .disposed(by: bag)
    }
}
