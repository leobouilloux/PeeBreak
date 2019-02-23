//
//  ToiletsListController.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import MapKit
import RxSwift

final class ToiletsController: RxViewController {
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel: ToiletsViewModelInterface

    init(with viewModel: ToiletsViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: ToiletsController.bundle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRxBindings()
    }
}

extension ToiletsController: UITableViewDelegate {
    // *****************************************************************************
    // - MARK: View
    func setupView() {
        setupTableView()
    }

    func setupTableView() {
        tableView.allowsSelection = false
        tableView.register(cell: ToiletCell.self)
    }

    func cell(for cellType: ToiletsCellType, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)

        switch (cellType, cell) {
        case let (.toilet(value: data), cell as ToiletCell):
            let cellViewModel = ToiletCellViewModel(with: data)
            cell.setup(with: cellViewModel)
        default: break
        }
        return cell
    }

    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings() {
        bindTheme()
        bindTableView()
    }

    func bindTheme() {
        themeService.rx
            .bind({ $0.backgroundColor }, to: view.rx.backgroundColor)
            .disposed(by: bag)
    }

    func bindTableView() {
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: bag)
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] _ in
            })
            .disposed(by: bag)
        viewModel.dataSource
            .drive(tableView.rx.items) { [weak self] _, row, cellType in
                let indexPath = IndexPath(row: row, section: 0)

                return self?.cell(for: cellType, indexPath: indexPath) ?? UITableViewCell()
            }
            .disposed(by: bag)
    }
}
