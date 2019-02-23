//
//  ToiletsCoordinatorOutput.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

public class ToiletsCoordinatorOutput: ToiletsCoordinatorOutputInterface {
    public let toiletsAction = PublishRelay<Void>()
    public let detailsAction = PublishRelay<Void>()
}
