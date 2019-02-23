//
//  RxTableViewCell.swift
//  Pee break
//
//  Created by Leo Marcotte on 23/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxSwift
import UIKit

open class RxTableViewCell: UITableViewCell {
    open var bag = DisposeBag()

    override open func awakeFromNib() {
        super.awakeFromNib()
    }

    override open func prepareForReuse() {
        super.prepareForReuse()

        bag = DisposeBag()
    }
}
