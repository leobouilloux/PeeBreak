//
//  ToiletCellViewModelInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

protocol ToiletCellViewModelInterface {
    var address: BehaviorRelay<String> { get }
    var hours: BehaviorRelay<String> { get }
    var lattitude: BehaviorRelay<Double> { get }
    var longitude: BehaviorRelay<Double> { get }
    var favoriteImage: BehaviorRelay<UIImage> { get }
}
