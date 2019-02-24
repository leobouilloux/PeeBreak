//
//  FavoritesController.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import CoreLocation
import MapKit
import RxMKMapView
import RxSwift

final class FavoritesController: RxViewController {
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var tableView: UITableView!

    private let refreshControl = UIRefreshControl()
    private let locationManager = CLLocationManager()
    private let viewModel: FavoritesViewModelInterface

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

extension FavoritesController: UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    // *****************************************************************************
    // - MARK: View
    func setupView() {
        setupMapView()
        setupTableView()
    }

    func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .mutedStandard
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true

        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    func setupTableView() {
        tableView.register(cell: ToiletCell.self)
        tableView.refreshControl = refreshControl
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
        bindTitle()
        bindMapView()
        bindTableView()
        bindRefreshControl()
    }

    func bindTheme() {
        themeService.rx
            .bind({ $0.backgroundColor }, to: view.rx.backgroundColor)
            .bind({ $0.backgroundColor }, to: tableView.rx.backgroundColor)
            .disposed(by: bag)
    }

    func bindTitle() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: bag)
    }

    func bindMapView() {
        mapView.rx.didFinishLoadingMap
            .asDriver()
            .drive(onNext: { [weak self] in
                if let coor = self?.mapView.userLocation.location?.coordinate {
                    self?.mapView.setRegion(
                        MKCoordinateRegion(
                            center: coor,
                            latitudinalMeters: 500,
                            longitudinalMeters: 500
                        ),
                        animated: false
                    )
                }
            })
            .disposed(by: bag)

        mapView.rx.didUpdateUserLocation
            .subscribe(onNext: { [weak self] userLocation in
                guard let location = userLocation.location else { return }
                self?.viewModel.userLocation.accept(location)
            })
            .disposed(by: bag)
        viewModel.annotations.drive(mapView.rx.annotations).disposed(by: bag)
    }

    func bindTableView() {
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: bag)
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let cellType = self?.viewModel.dataSource.value[indexPath.row] else { return }

                switch cellType {
                case let .toilet(data): self?.viewModel.output.toiletDetailsAction.accept(data)
                }
            })
            .disposed(by: bag)
        viewModel.dataSource
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items) { [weak self] _, row, cellType in
                let indexPath = IndexPath(row: row, section: 0)

                return self?.cell(for: cellType, indexPath: indexPath) ?? UITableViewCell()
            }
            .disposed(by: bag)
    }

    func bindRefreshControl() {
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                if self?.refreshControl.isRefreshing == true {
                    self?.viewModel.output.updateDataAction.accept(())
                }
            })
            .disposed(by: bag)
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                if !isLoading {
                    self?.refreshControl.endRefreshing()
                }
            })
            .disposed(by: bag)
    }
}
