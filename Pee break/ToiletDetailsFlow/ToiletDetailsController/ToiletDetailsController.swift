//
//  ToiletDetailsController.swift
//  Pee break
//
//  Created by Leo Marcotte on 24/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import MapKit
import MessageUI
import UIKit

final class ToiletDetailsController: RxViewController, MFMessageComposeViewControllerDelegate {
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var addressImageView: UIImageView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var hoursImageView: UIImageView!
    @IBOutlet private weak var hoursLabel: UILabel!

    private var actionBarButton = UIBarButtonItem()
    private var alertController = UIAlertController()

    private let viewModel: ToiletDetailsViewModelInterface

    init(with viewModel: ToiletDetailsViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: ToiletDetailsController.bundle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRxBindings()
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {

        controller.dismiss(animated: true, completion: nil)
    }
}

private extension ToiletDetailsController {
    // *****************************************************************************
    // - MARK: View
    func setupView() {
        setupNavigationBar()
        setupAlertController()
    }

    func setupNavigationBar() {
        actionBarButton.image = Asset.dotsHorizontal.image
        navigationItem.rightBarButtonItem = actionBarButton
    }

    func setupAlertController() {
        alertController = UIAlertController(title: "Choisir une action", message: "", preferredStyle: .actionSheet)

        let favoritesAction = UIAlertAction(title: "Ajouter aux favoris", style: .default) { [weak self] _ in
            self?.viewModel.output.addFavoriteAction.accept(())
        }
        let shareSMSAction = UIAlertAction(title: "Partager par SMS", style: .default) { [weak self] _ in
            guard let toiletData = self?.viewModel.data else { return }

            if MFMessageComposeViewController.canSendText() {
                let controller = MFMessageComposeViewController()

                controller.body = """
                Voici des toilettes publiques que je vous recommande
                Adresse: \(toiletData.address)
                Horaire: \(toiletData.hours)
                """
                controller.messageComposeDelegate = self
                controller.recipients = []
                self?.present(controller, animated: true)
            }
        }

        let googleMapAction = UIAlertAction(title: "Ouvrir dans Google Map", style: .default) { [weak self] _ in
            guard let viewModel = self?.viewModel else { return }
            viewModel.output.googleMapAction.accept(viewModel.data)
        }
        let applePlanAction = UIAlertAction(title: "Ouvrir dans Apple Plan", style: .default) { [weak self] _ in
            guard let viewModel = self?.viewModel else { return }
            viewModel.output.applePlanAction.accept(viewModel.data)
        }
        let cancelAction = UIAlertAction(title: "Annuler", style: .destructive, handler: nil)

        alertController.addAction(favoritesAction)
        alertController.addAction(shareSMSAction)
        alertController.addAction(googleMapAction)
        alertController.addAction(applePlanAction)
        alertController.addAction(cancelAction)
    }

    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings() {
        bindTheme()
        bindActionBarButton()
        bindMap()
        bindAddressImage()
        bindAddress()
        bindHoursImage()
        bindHours()
    }

    func bindTheme() {
        themeService.rx
            .bind({ $0.textColor }, to: addressImageView.rx.tintColor)
            .bind({ $0.textColor }, to: addressLabel.rx.textColor)
            .bind({ $0.textColor }, to: hoursImageView.rx.tintColor)
            .bind({ $0.textColor }, to: hoursLabel.rx.textColor)
            .disposed(by: bag)
    }

    func bindActionBarButton() {
        actionBarButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let alertController = self?.alertController else { return }
                self?.present(alertController, animated: true)
            })
            .disposed(by: bag)
    }
    
    func bindMap() {
        
    }

    func bindAddressImage() {
        viewModel.addressImage.bind(to: addressImageView.rx.image).disposed(by: bag)
    }

    func bindAddress() {
        viewModel.address.bind(to: addressLabel.rx.text).disposed(by: bag)
    }

    func bindHoursImage() {
        viewModel.hoursImage.bind(to: hoursImageView.rx.image).disposed(by: bag)
    }

    func bindHours() {
        viewModel.hours.bind(to: hoursLabel.rx.text).disposed(by: bag)
    }
}
