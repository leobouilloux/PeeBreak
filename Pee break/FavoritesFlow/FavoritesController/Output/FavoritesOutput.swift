//
//  FavoritesOutput.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

final class FavoritesOutput: FavoritesOutputInterface {
    let updateDataAction = PublishRelay<Void>()
    let toiletDetailsAction = PublishRelay<ToiletData>()
}
