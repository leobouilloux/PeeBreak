//
//  FavoritesController.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

final class FavoritesController: RxViewController {
    let viewModel: FavoritesViewModelInterface

    init(with viewModel: FavoritesViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: FavoritesController.bundle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRxBindings()
    }
}

private extension FavoritesController {
    // *****************************************************************************
    // - MARK: View
    func setupView() {

    }

    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings() {
        bindTheme()
    }

    func bindTheme() {
        themeService.rx
            .bind({ $0.backgroundColor }, to: view.rx.backgroundColor)
            .disposed(by: bag)
    }
}
