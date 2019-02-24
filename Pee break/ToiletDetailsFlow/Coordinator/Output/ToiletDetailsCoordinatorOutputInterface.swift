//
//  ToiletDetailsCoordinatorOutputInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

protocol ToiletDetailsCoordinatorOutputInterface {
    var finishFlowAction: PublishRelay<Void> { get }
    var addFavoriteAction: PublishRelay<Void> { get }
    var shareSMSAction: PublishRelay<ToiletData> { get }
    var googleMapAction: PublishRelay<ToiletData> { get }
    var applePlanAction: PublishRelay<ToiletData> { get }
}
