//
//  RequestManager.swift
//  Pee break
//
//  Created by Leo Marcotte on 22/02/2019.
//  Copyright © 2019 Leo Marcotte. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift

final class RequestManager {
    private let bag = DisposeBag()
    private let endpoint = "https://data.ratp.fr/api"

    init() {}

    func fetchToilets() -> Observable<(HTTPURLResponse, Any)> {
        let path = "/records/1.0/search/"
        let parameters: Parameters = [
            "dataset": "sanisettesparis2011",
            "rows": 1000
        ]
        guard let url = URL(string: endpoint + path) else { fatalError("URL is not valid") }

        return RxAlamofire
            .requestJSON(.get, url, parameters: parameters, encoding: URLEncoding.default, headers: nil)
    }
}
