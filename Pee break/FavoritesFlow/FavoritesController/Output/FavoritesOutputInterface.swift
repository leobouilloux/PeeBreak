//
//  FavoritesOutputInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

protocol FavoritesOutputInterface {
    var updateDataAction: PublishRelay<Void> { get }
    var toiletDetailsAction: PublishRelay<ToiletData> { get }
}
