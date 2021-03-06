//
//  FavoritesCoordinatorOutput.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

final class FavoritesCoordinatorOutput: FavoritesCoordinatorOutputInterface {
    let toiletsAction = PublishRelay<Void>()
    let toiletDetailsAction = PublishRelay<ToiletData>()
}
