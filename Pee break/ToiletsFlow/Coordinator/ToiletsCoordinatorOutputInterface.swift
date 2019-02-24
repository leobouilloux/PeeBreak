//
//  ToiletsCoordinatorOutputInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

protocol ToiletsCoordinatorOutputInterface {
    var toiletsAction: PublishRelay<Void> { get }
    var toiletDetailsAction: PublishRelay<ToiletData> { get }
}
