//
//  HttpClient.swift
//  ComponentNetworkRouterDemo
//
//  Created by 黃柏叡 on 2019/10/2.
//  Copyright © 2019 黃柏叡. All rights reserved.
//

import Foundation

class HttpClient {
    static let shared = HttpClient()
    lazy var router: Router = {
        let session = URLSession(configuration: .default)
        let decisions = Decisions.defaults(session: session)
        return Router(with: decisions)
    }()
}

