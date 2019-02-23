//
//  RealmManager.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RealmSwift
import RxRealm
import RxSwift
import SwiftyJSON

final class RealmManager: RealmProvider {
    let realm: Realm
    let requestManger = RequestManager()
    private let bag = DisposeBag()

    init() {
        guard let realm = try? Realm() else { fatalError("Couldn't init realm store") }
        self.realm = realm
    }

    func updateData() -> Observable<(HTTPURLResponse, Any)> {
        let request = requestManger.fetchToilets()

        request
            .subscribe(onNext: { [weak self] _, json in
                if let toiletsData = self?.parseToiletsData(data: json) {
                    self?.saveToiletsData(data: toiletsData)
                }
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: bag)
        return request
    }

    func getToilets() -> Observable<[ToiletData]> {
        let data = realm.objects(ToiletData.self)

        return Observable.array(from: data)
    }

    func getFavorites() -> Observable<[ToiletData]> {
        let data = realm.objects(ToiletData.self).filter("isFavorite == true")

        return Observable.array(from: data)
    }

    // *****************************************************************************
    // - MARK: Helpers
    private func parseToiletsData(data: Any) -> [ToiletData] {
        let json = JSON(data)

        let records = json["records"].arrayValue
        return records.map { toilet in
            let toiletData = ToiletData()
            toiletData.id = toilet["recordid"].stringValue

            let fields = toilet["fields"]

            // Address
            let street = fields["nom_voie"].stringValue
            let streetNumber = fields["numero_voie"].stringValue
            let arrondisment = fields["arrondissement"].stringValue
            toiletData.address = [streetNumber, street, "750\(arrondisment)"].joined(separator: " ")

            // Coordinates
            let coordinates = fields["geom_x_y"].arrayValue
            toiletData.x = coordinates.first?.doubleValue ?? 0
            toiletData.y = coordinates.last?.doubleValue ?? 0

            // Opening hours
            toiletData.hours = fields["horaires_ouverture"].stringValue

            return toiletData
        }
    }

    private func saveToiletsData(data: [ToiletData]) {
        do {
            try realm.write {
                realm.add(data, update: true)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
