//
//  ToiletsCellType.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

enum ToiletsCellType {
    case toilet(value: ToiletData)

    var identifier: String {
        switch self {
        case .toilet: return ToiletCell.identifier
        }
    }
}
