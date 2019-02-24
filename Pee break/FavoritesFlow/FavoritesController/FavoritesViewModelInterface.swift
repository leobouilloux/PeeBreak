//
//  FavoritesViewModelInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import CoreLocation
import MapKit
import RxCocoa

protocol FavoritesViewModelInterface {
    var title: BehaviorRelay<String> { get }

    var dataSource: BehaviorRelay<[ToiletsCellType]> { get }
    var annotations: Driver<[MKPointAnnotation]> { get }
    var userLocation: BehaviorRelay<CLLocation?> { get }
    var isLoading: PublishRelay<Bool> { get }
    var output: FavoritesOutputInterface { get }
}
