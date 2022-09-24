//
//  CurrencyViewController.swift
//  PayPayExchangeRates
//
//  Created by RickH on 2022/9/24.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    let viewModel = CurrencyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getExchangeRate()
    }
}
