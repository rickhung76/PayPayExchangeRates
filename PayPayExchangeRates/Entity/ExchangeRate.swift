//
//  ExchangeRate.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import Foundation

// MARK: - ExchangeRate Response Model
struct ExchangeRate: Codable {
    let disclaimer: String
    let license: String
    let timestamp: Int
    let base: String
    let rates: [String: Double]
}

class ExchangeRateRequest: Request {
    
    typealias Response = ExchangeRate
    
    var baseURL: String {
        "https://openexchangerates.org/api"
    }
    
    var path: String {
        "/latest.json"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var parameters: Parameters? {
        nil
    }
    
    var urlParameters: Parameters? {
        ["app_id": appID]
    }
    
    var bodyEncoding: ParameterEncoding? {
        .urlEncoding
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    let appID: String
    
    init(appID: String = "d701f44a8d314e5b9d732d6381acc8ac") {
        self.appID = appID
    }
}
