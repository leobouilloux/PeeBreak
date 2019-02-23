//
//  FavoritesCoordinatorOutput.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

public class FavoritesCoordinatorOutput: FavoritesCoordinatorOutputInterface {
    public let toiletsAction = PublishRelay<Void>()
    public let detailsAction = PublishRelay<Void>()
}
