//
//  SplashScreenViewModelInterface.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa

protocol SplashScreenViewModelInterface {
    var backgroundImage: BehaviorRelay<UIImage> { get }
    var isLoading: PublishRelay<Bool> { get }
    var output: SplashScreenOutputInterface { get }

    func fetchData()
}
