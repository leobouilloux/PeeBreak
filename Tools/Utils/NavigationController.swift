//
//  NavigationController.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxSwift
import UIKit

public final class NavigationController: UINavigationController {
    private let bag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupRxBindings()
    }
}

private extension NavigationController {
    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings() {
        bindTheme()
    }

    func bindTheme() {
        themeService.rx
            .bind({ $0.backgroundColor }, to: navigationBar.rx.barTintColor)
            .bind({ $0.navigationBarTintColor }, to: navigationBar.rx.titleTextAttributes)
            .disposed(by: bag)
    }
}
