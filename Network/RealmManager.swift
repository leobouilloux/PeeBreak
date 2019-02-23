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

final class RealmManager: RealmProvider {
    let realm: Realm

    init() {
        guard let realm = try? Realm() else { fatalError("Couldn't init realm store") }
        self.realm = realm
    }

    func getToilets() -> Observable<[ToiletData]> {
        let data = realm.objects(ToiletData.self)

        return Observable.array(from: data)
    }

    func getFavorites() -> Observable<[ToiletData]> {
        let data = realm.objects(ToiletData.self).filter("isFavorite == true")

        return Observable.array(from: data)
    }
}
