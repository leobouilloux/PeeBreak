//
//  UITableViewExtension.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import UIKit

public extension UITableView {
    public func register(cell: UITableViewCell.Type) {
        register(UINib(nibName: cell.nameOfClass, bundle: cell.bundle), forCellReuseIdentifier: cell.identifier)
    }
}
