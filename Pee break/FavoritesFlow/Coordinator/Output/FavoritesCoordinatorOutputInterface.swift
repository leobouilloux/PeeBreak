//
//  FavoritesCoordinatorOutputInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

protocol FavoritesCoordinatorOutputInterface {
    var toiletsAction: PublishRelay<Void> { get }
    var detailsAction: PublishRelay<ToiletData> { get }
}
