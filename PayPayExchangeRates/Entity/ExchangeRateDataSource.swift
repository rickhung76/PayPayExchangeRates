//
//  ExchangeRateDataSource.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import Foundation

protocol ExchangeRateDataSource {
    func getExchangeRate(
        completion: @escaping (Result<ExchangeRate, Error>)-> Void
    )
}

extension HttpClient: ExchangeRateDataSource {
    func getExchangeRate(
        completion: @escaping (Result<ExchangeRate, Error>)-> Void
    ) {
        let req = ExchangeRateRequest()
        router.send(req) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
