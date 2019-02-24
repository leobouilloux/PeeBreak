//
//  ToiletDetailsCoordinatorOutput.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

final class ToiletDetailsCoordinatorOutput: ToiletDetailsCoordinatorOutputInterface {
    let finishFlowAction = PublishRelay<Void>()
    let addFavoriteAction = PublishRelay<Void>()
    let shareSMSAction = PublishRelay<ToiletData>()
    let googleMapAction = PublishRelay<ToiletData>()
    let applePlanAction = PublishRelay<ToiletData>()
}
