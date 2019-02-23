//
//  NSObjectExtension.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import Foundation

public extension NSObject {
    public var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }

    public class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

    public class var bundle: Bundle {
        return Bundle(for: self)
    }
}
