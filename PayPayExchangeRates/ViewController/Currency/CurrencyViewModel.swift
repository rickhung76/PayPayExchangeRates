//
//  CurrencyViewModel.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import Foundation

class CurrencyViewModel {
    
    private let store: PersistanceStorable

    init(store: PersistanceStorable = UserDefaultsStorable.shared) {
        self.store = store
    }
    
    func getExchangeRate() {
        print(store.exchangeRate)
    }
}
