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
    @objc dynamic var address: String = ""
    @objc dynamic var hours: String = ""
    @objc dynamic var x: Double = 0
    @objc dynamic var y: Double = 0

    let distance = RealmOptional<Float>()

    @objc dynamic var isFavorite: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }

    override static func ignoredProperties() -> [String] {
        return ["distance"]
    }
}
