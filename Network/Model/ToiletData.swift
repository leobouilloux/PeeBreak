//
//  ToiletData.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RealmSwift

final class ToiletData: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
}
