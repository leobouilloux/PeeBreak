//
//  ToiletDetailsViewModelInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import MapKit
import RxCocoa

protocol ToiletDetailsViewModelInterface {
    var data: ToiletData { get }
    var hoursImage: BehaviorRelay<UIImage> { get }
    var addressImage: BehaviorRelay<UIImage> { get }
    var address: BehaviorRelay<String> { get }
    var hours: BehaviorRelay<String> { get }
    var annotations: Driver<[MKPointAnnotation]> { get }
    var output: ToiletDetailsOutputInferface { get }
}
