//
//  ToiletsViewModel.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa
import RxSwift

final class ToiletsViewModel: ToiletsViewModelInterface {
    let provider: Provider
    var dataSource: Driver<[ToiletsCellType]> {
        return privateDataSource.asDriver(onErrorJustReturn: [])
    }

    private let privateDataSource = BehaviorRelay<[ToiletsCellType]>(value: [])
    private let bag = DisposeBag()

    init(with provider: Provider) {
        self.provider = provider

        fetchToiletsData()
        getData()

        privateDataSource
            .subscribe(onNext: { cells in
            print(cells)
        })
            .disposed(by: bag)
    }
}

private extension ToiletsViewModel {
    func getData() {

        provider.dataProvider.getToilets()
            .map({ $0.map { ToiletsCellType.toilet(value: $0) } })
            .bind(to: privateDataSource)
            .disposed(by: bag)
    }

    func fetchToiletsData() {
        provider.dataProvider.updateData()
    }
}
