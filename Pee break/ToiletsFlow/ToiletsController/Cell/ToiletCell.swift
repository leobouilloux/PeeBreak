//
//  ToiletCell.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class ToiletCell: RxTableViewCell {
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var hoursLabel: UILabel!
    @IBOutlet private weak var favoriteImageView: UIImageView!

    var viewModel: ToiletCellViewModelInterface?

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
    }

    func setup(with viewModel: ToiletCellViewModelInterface) {
        self.viewModel = viewModel

        setupRxBindings(with: viewModel)
    }
}

private extension ToiletCell {
    func setupRxBindings(with viewModel: ToiletCellViewModelInterface) {
        bindTheme()
        bindAddress(with: viewModel)
        bindHours(with: viewModel)
        bindFavoriteImage(with: viewModel)
    }

    func bindTheme() {
        themeService.rx
            .bind({ $0.backgroundColor }, to: rx.backgroundColor)
            .bind({ $0.textColor }, to: addressLabel.rx.textColor)
            .bind({ $0.textColor }, to: hoursLabel.rx.textColor)
            .bind({ $0.textColor }, to: favoriteImageView.rx.tintColor)
    }

    func bindAddress(with viewModel: ToiletCellViewModelInterface) {
        viewModel.address.bind(to: addressLabel.rx.text).disposed(by: bag)
    }

    func bindHours(with viewModel: ToiletCellViewModelInterface) {
        viewModel.hours.bind(to: hoursLabel.rx.text).disposed(by: bag)
    }

    func bindFavoriteImage(with viewModel: ToiletCellViewModelInterface) {
        viewModel.favoriteImage.bind(to: favoriteImageView.rx.image).disposed(by: bag)
    }
}
