//
//  DeeplinkOption.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import RxCocoa
import UIKit

enum DeepLinkURLConstants {}

public enum DeepLinkOption {
    public static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            URLComponents(url: url, resolvingAgainstBaseURL: true) != nil {
        }
        return nil
    }

    public static func build(with url: URL) -> DeepLinkOption? {
        let options = parse(url: url)
        switch options.screen {
        default: return nil
        }
    }

    private static func parse(url: URL) -> (screen: String, arguments: [String]) {
        let screen = url.host ?? ""
        var components = url.pathComponents
        components.removeAll { $0 == "/" }
        return (screen: screen, arguments: components)
    }
}
