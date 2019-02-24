//
//  ToiletDetailsCoordinator.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import MapKit
import MessageUI
import RxSwift

final class ToiletDetailsCoordinator: BaseCoordinator {
    private let factory: ToiletDetailsFactoryInterface
    public let output: ToiletDetailsCoordinatorOutputInterface = ToiletDetailsCoordinatorOutput()
    private let provider: Provider
    private let bag = DisposeBag()

    init(router: Router, factory: ToiletDetailsFactoryInterface, provider: Provider) {
        self.factory = factory
        self.provider = provider
        super.init(router: router)

        bindOutputs()
    }

    func start(with data: ToiletData) {
        setupRootCoordinator(with: data)
    }

    override public func start(with option: DeepLinkOption? = nil) {}

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {

        controller.dismiss(animated: true, completion: nil)
    }
}

private extension ToiletDetailsCoordinator {
    // *****************************************************************************************************************
    // MARK: - Setup
    func setupRootCoordinator(with data: ToiletData) {
        let viewModel = ToiletDetailsViewModel(with: provider, data: data)
        viewModel.output.finishFlowAction.bind(to: output.finishFlowAction).disposed(by: bag)
        viewModel.output.googleMapAction.bind(to: output.googleMapAction).disposed(by: bag)
        viewModel.output.applePlanAction.bind(to: output.applePlanAction).disposed(by: bag)

        let toiletDetailsPresentable = factory.makeToiletDetailsPresentable(with: viewModel)
        router.push(toiletDetailsPresentable)
    }

    // *****************************************************************************************************************
    // MARK: - Rx Bindings
    func bindOutputs() {
        bindGoogleMapOutput()
        bindApplePlanOutput()
    }

    func bindGoogleMapOutput() {
        output.googleMapAction
            .subscribe(onNext: { toiletData in
                guard
                    let googleMapURL = URL(string: "comgooglemaps://"),
                    UIApplication.shared.canOpenURL(googleMapURL),
                    let url = URL(string: "comgooglemaps://?saddr=&daddr=\(toiletData.x)),\(toiletData.y))&directionsmode=driving")
                    else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        .disposed(by: bag)
    }

    func bindApplePlanOutput() {
        output.applePlanAction
            .subscribe(onNext: { toiletData in
                let latitude: CLLocationDegrees = toiletData.x
                let longitude: CLLocationDegrees = toiletData.y

                let regionDistance: CLLocationDistance = 1000
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegion(
                    center: coordinates,
                    latitudinalMeters: regionDistance,
                    longitudinalMeters: regionDistance
                )
                let options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                ]
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = "Place Name"
                mapItem.openInMaps(launchOptions: options)
            })
            .disposed(by: bag)

    }
}
