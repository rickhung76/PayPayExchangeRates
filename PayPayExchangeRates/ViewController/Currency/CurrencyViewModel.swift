//
//  CurrencyViewModel.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import Foundation

class CurrencyViewModel {
    
    let dataSource: ExchangeRateDataSource
    
    init(dataSource: ExchangeRateDataSource = HttpClient.shared) {
        self.dataSource = dataSource
    }
    
    func getExchangeRate() {
        dataSource.getExchangeRate { result in
            print(result)
        }
    }
}
