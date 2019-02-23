//
//  TabbarController.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class TabbarController: UITabBarController, UITabBarControllerDelegate {
    private var didSetup = false
    private let bag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !didSetup {
            setupItems()
            selectedIndex = 0
            didSetup = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        tabBar.isTranslucent = false

        setupRxBindings()
    }
}

private extension TabbarController {

    func setupRxBindings() {
        bindTheme()
    }

    func bindTheme() {
        themeService.rx
            .bind({ $0.backgroundColor }, to: tabBar.rx.backgroundColor)
            .bind({ $0.textColor }, to: tabBar.rx.tintColor)
            .disposed(by: bag)
    }

    func setupItems() {
        let bottomBarItems: [(image: UIImage, title: String)] = [
            (Asset.toilets.image, "Toilettes"),
            (Asset.favourite.image, "Favoris")
        ]

        let items = bottomBarItems.enumerated().map { index, item in
            UITabBarItem(title: item.title, image: item.image, tag: index)
        }

        guard let controllers = viewControllers else { return }

        zip(controllers, items).enumerated()
            .map { ($0, $1.0, $1.1) }
            .forEach { _, controller, item in
                controller.tabBarItem = item
        }
    }
}
