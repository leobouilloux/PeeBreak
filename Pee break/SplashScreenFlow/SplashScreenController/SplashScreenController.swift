//
//  SplashScreenController.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import UIKit

final class SplashScreenController: RxViewController {
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    private let viewModel: SplashScreenViewModelInterface

    init(with viewModel: SplashScreenViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: SplashScreenController.bundle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRxBindings()
    }
}

private extension SplashScreenController {
    // *****************************************************************************
    // - MARK: View
    func setupView() {
        setupActivityIndicator()
    }

    func setupActivityIndicator() {
        activityIndicator.isHidden = true
    }

    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings() {
        bindBackgroundImage()
        bindIsLoading()
    }

    func bindBackgroundImage() {
        viewModel.backgroundImage.bind(to: backgroundImageView.rx.image).disposed(by: bag)
    }

    func bindIsLoading() {
        viewModel.isLoading.bind(to: activityIndicator.rx.isHidden).disposed(by: bag)
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            })
            .disposed(by: bag)
    }
}
