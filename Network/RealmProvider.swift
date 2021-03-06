//
//  RealmProvider.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxSwift

protocol RealmProvider {
    func updateData() -> Observable<(HTTPURLResponse, Any)>
    func getToilets() -> Observable<[ToiletData]>
    func getFavorites() -> Observable<[ToiletData]>
    func addFavorite(data: ToiletData)
    func removeFavorite(data: ToiletData)
}
