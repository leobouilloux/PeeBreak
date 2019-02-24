//
//  Theme.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxTheme
import UIKit

public let themeService = ThemeType.service(initial: .light)

public enum ThemeType: ThemeProvider {
    case light
    case dark

    public var associatedObject: Theme {
        switch self {
        case .light: return LightTheme()
        case .dark: return DarkTheme()
        }
    }
}

public protocol Theme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var yellowColor: UIColor { get }
    var navigationBarTintColor: [NSAttributedString.Key: Any] { get }
    var statusBarStyle: UIStatusBarStyle { get }
}

public struct LightTheme: Theme {
    public let backgroundColor: UIColor = .white
    public let textColor: UIColor = .black
    public let yellowColor: UIColor = .init(red: 244 / 255, green: 175 / 255, blue: 72 / 255, alpha: 1)
    public let statusBarStyle: UIStatusBarStyle = .default
    public let navigationBarTintColor: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black]
}

public struct DarkTheme: Theme {
    public let backgroundColor: UIColor = .black
    public let textColor: UIColor = .white
    public let yellowColor: UIColor = .init(red: 244 / 255, green: 175 / 255, blue: 72 / 255, alpha: 1)
    public let statusBarStyle: UIStatusBarStyle = .lightContent
    public let navigationBarTintColor: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]
}
