//
//  ExchangeRateUpdateTask.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/25.
//

import Foundation

class ExchangeRateUpdateTask: BackgroundPollingTask {
    
    private let dataSource: ExchangeRateDataSource
    private let persistanceStore: PersistanceStorable
    
    var completion: (() -> Void)?
    
    var repeatingTimeInterval: Int = 30*60
    private var accumulateTimeInterval: Int = 0
    
    func shouldApply(by timeInterval: Int) -> Bool {
        if accumulateTimeInterval == 0 {
            accumulateTimeInterval += timeInterval
            return true
            
        } // fire at first time
        accumulateTimeInterval += timeInterval
        guard accumulateTimeInterval >= repeatingTimeInterval else { return false }
        accumulateTimeInterval = 0
        return true
    }
    
    func apply() {
        dataSource.getExchangeRate { result in
            switch result {
            case .success(let exchangeRate):
                print(exchangeRate)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    init(
        dataSource: ExchangeRateDataSource = HttpClient.shared,
        persistanceStore: PersistanceStorable = UserDefaultsStorable.shared,
        completion: (() -> Void)? = nil
    ) {
        self.dataSource = dataSource
        self.persistanceStore = persistanceStore
        self.completion = completion
    }
}

