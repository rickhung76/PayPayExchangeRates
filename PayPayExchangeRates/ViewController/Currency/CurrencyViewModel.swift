//
//  CurrencyViewModel.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import Foundation
import Combine

class CurrencyViewModel {
    
    private let store: PersistanceStorable
    
    private let queue = DispatchQueue(label: "Serial Queue", qos: .userInteractive)
    
    private var exchangeRate: ExchangeRate? {
        store.exchangeRate
    }
    
    var pickerData: [String] {
        guard let keys = exchangeRate?.rates.keys else { return [] }
        return Array(keys).sorted()
    }
    
    var pickedCountry: String {
        didSet {
            generateCurrencyCellViewModels(with: amount)
        }
    }
    
    var amount: String {
        didSet {
            generateCurrencyCellViewModels(with: amount)
        }
    }
    
    @Published
    var currencyCellVM: [CurrencyTableViewCellVM] = []

    init(
        store: PersistanceStorable = UserDefaultsStorable.shared,
        defaultCountry: String = "USD",
        defaultAmount: String = "0"
    ) {
        self.store = store
        self.pickedCountry = defaultCountry
        self.amount = defaultAmount
        generateCurrencyCellViewModels(with: amount)
    }
    
    func exchangeCurrency(amount: Double, to: String) -> String {
        guard let rates = exchangeRate?.rates,
              let fromRate = rates[pickedCountry.uppercased()],
              let toRate = rates[to.uppercased()]
        else { return "NaN" }
        let result = amount / fromRate * toRate
        return String(format: "%.5f", result)
    }
    
    private func generateCurrencyCellViewModels(with amount: String) {
        queue.sync {
            guard let amountValue = Double(amount),
                  let rates = self.exchangeRate?.rates else {
                self.currencyCellVM = []
                return
            }
            
            self.currencyCellVM = rates
                .sorted(by: { $0.0 < $1.0})
                .map({ (key, _) in
                let amount = self.exchangeCurrency(amount: amountValue, to: key)
                return CurrencyTableViewCellVM(country: key, amount: amount)
            })
        }
    }
}
