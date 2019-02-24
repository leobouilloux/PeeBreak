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
    @IBOutlet private weak var roundView: UIView!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var chevronImageView: UIImageView!

    var viewModel: ToiletCellViewModelInterface?

    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
    }

    func setup(with viewModel: ToiletCellViewModelInterface) {
        self.viewModel = viewModel

        setupRxBindings(with: viewModel)
    }
}

private extension ToiletCell {
    // *****************************************************************************
    // - MARK: View
    func setupView() {
        selectionStyle = .none

        setupRoundView()
        setupHoursLabel()
    }

    func setupRoundView() {
        roundView.layer.cornerRadius = roundView.frame.height / 2
        roundView.clipsToBounds = true
    }

    func setupHoursLabel() {
        hoursLabel.layer.cornerRadius = 2
        hoursLabel.clipsToBounds = true
    }

    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings(with viewModel: ToiletCellViewModelInterface) {
        bindTheme()
        bindDistance(with: viewModel)
        bindFavoriteImage(with: viewModel)
        bindAddress(with: viewModel)
        bindHours(with: viewModel)
        bindChevronImage(with: viewModel)
    }

    func bindTheme() {
        themeService.rx
            .bind({ $0.backgroundColor }, to: rx.backgroundColor)
            .bind({ $0.textColor }, to: addressLabel.rx.textColor)
            .bind({ $0.textColor }, to: chevronImageView.rx.tintColor)
            .bind({ $0.yellowColor }, to: favoriteImageView.rx.tintColor)
            .disposed(by: bag)
    }

    func bindDistance(with viewModel: ToiletCellViewModelInterface) {
        viewModel.distance.bind(to: distanceLabel.rx.text).disposed(by: bag)
    }

    func bindFavoriteImage(with viewModel: ToiletCellViewModelInterface) {
        viewModel.favoriteImage.bind(to: favoriteImageView.rx.image).disposed(by: bag)
    }

    func bindAddress(with viewModel: ToiletCellViewModelInterface) {
        viewModel.address.bind(to: addressLabel.rx.text).disposed(by: bag)
    }

    func bindHours(with viewModel: ToiletCellViewModelInterface) {
        viewModel.hours.bind(to: hoursLabel.rx.text).disposed(by: bag)
    }

    func bindChevronImage(with viewModel: ToiletCellViewModelInterface) {
        viewModel.chevronImage.bind(to: chevronImageView.rx.image).disposed(by: bag)
    }
}
