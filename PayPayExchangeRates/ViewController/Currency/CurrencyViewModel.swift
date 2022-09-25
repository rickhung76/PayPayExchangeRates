//
//  CurrencyViewModel.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import Foundation

class CurrencyViewModel {
    
    private let store: PersistanceStorable
    
    var pickerData: [String] = ["1", "2", "3", "4", "5"]

    init(store: PersistanceStorable = UserDefaultsStorable.shared) {
        self.store = store
    }
    
    func getExchangeRate() {
        print(store.exchangeRate)
    }
}
